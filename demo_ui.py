import json
import re
from pathlib import Path

import requests
import streamlit as st
from pyDatalog import pyDatalog


st.set_page_config(page_title="KRR System Demo", page_icon="🍝", layout="wide")

ROOT = Path(__file__).resolve().parent
RECIPES_DIR = ROOT / "italian_recipes_json"
FACTS_DIR = ROOT / "FoodData_Central_foundation_food_csv_2025-12-18"
FACTS_NUTRIENTS = FACTS_DIR / "facts_nutrients.pl"
FACTS_OVERRIDES = FACTS_DIR / "facts_standardized_overrides.pl"
FACTS_ALLERGENS = FACTS_DIR / "facts_allergens.pl"

SYSTEM_MAP = {
    "Root": [
        "README.md: project goal and architecture intent.",
        "rag_llm.ipynb: RAG retrieval and LLM answering prototype.",
        "italian_mealdb_predicates.ipynb: recipe JSON and predicates generation.",
    ],
    "FoodData_Central_foundation_food_csv_2025-12-18": [
        "USDA source CSV files (food, nutrients, categories, portions, methods).",
        "Generated fact files: facts_ingredients.pl, facts_nutrients.pl, facts_allergens.pl.",
        "Notebook pipelines: ingredent FOPC.ipynb, query_comparison.ipynb, recipe_fopc.ipynb.",
    ],
    "italian_recipes_json": [
        "Recipe JSON files from MealDB used by RAG.",
        "dislikes.csv for user preference constraints.",
        "Contains duplicated USDA slices (food.csv, food_attribute.csv, food_nutrient.csv).",
    ],
}

NUTRIENT_KEYS = ("fat", "calories", "protein", "carbs")
QUERY_STOPWORDS = {
    "how",
    "do",
    "i",
    "make",
    "cook",
    "prepare",
    "the",
    "a",
    "an",
    "for",
    "to",
    "with",
    "without",
    "show",
    "give",
    "me",
    "recipe",
    "recipes",
    "what",
    "is",
    "are",
    "can",
    "you",
}
ALLERGEN_SYNONYMS = {
    "gluten": "wheat",
    "wheat": "wheat",
    "dairy": "milk",
    "milk": "milk",
    "egg": "egg",
    "eggs": "egg",
    "fish": "fish",
    "shellfish": "shellfish",
    "soy": "soy",
    "sesame": "sesame",
    "peanut": "peanut",
    "peanuts": "peanut",
    "nut": "tree_nuts",
    "nuts": "tree_nuts",
    "tree nuts": "tree_nuts",
}


def safe_atom(text: str) -> str:
    token = re.sub(r"[^a-zA-Z0-9]+", "_", (text or "").strip().lower())
    return token.strip("_")


def parse_meal_ingredients(meal: dict) -> list[dict]:
    out = []
    for i in range(1, 21):
        ing = meal.get(f"strIngredient{i}")
        if not ing or not str(ing).strip():
            continue
        measure = (meal.get(f"strMeasure{i}") or "").strip()
        out.append(
            {
                "name_raw": str(ing).strip(),
                "name_atom": safe_atom(str(ing)),
                "measure": measure,
            }
        )
    return out


def recipe_to_text(recipe: dict) -> str:
    ingredients = ", ".join(x["name_raw"] for x in recipe["ingredients"])
    return (
        f"Recipe: {recipe['display_name']}\n"
        f"Ingredients: {ingredients}\n"
        f"Instructions: {recipe['instructions'][:900]}"
    )


def query_terms(text: str) -> set[str]:
    terms = set(re.findall(r"[a-zA-Z]+", (text or "").lower()))
    return {t for t in terms if len(t) >= 3 and t not in QUERY_STOPWORDS}


def parse_rag_doc(doc: str) -> dict:
    recipe = ""
    ingredients = ""
    instructions = ""
    m_recipe = re.search(r"Recipe:\s*(.+)", doc)
    m_ing = re.search(r"Ingredients:\s*(.+)", doc)
    m_inst = re.search(r"Instructions:\s*(.+)", doc, flags=re.DOTALL)
    if m_recipe:
        recipe = m_recipe.group(1).strip()
    if m_ing:
        ingredients = m_ing.group(1).strip()
    if m_inst:
        instructions = m_inst.group(1).strip()
    return {"recipe": recipe, "ingredients": ingredients, "instructions": instructions}


def match_recipes_by_name(query: str, recipes: list[dict], top_k: int = 3) -> list[dict]:
    q_terms = query_terms(query)
    scored = []
    for recipe in recipes:
        name_terms = query_terms(recipe["display_name"])
        overlap = len(q_terms.intersection(name_terms))
        if overlap > 0:
            scored.append((overlap, recipe))
    scored.sort(key=lambda x: x[0], reverse=True)
    return [r for _, r in scored[:top_k]]


def parse_aliases_from_fact_text(content: str) -> dict[str, str]:
    alias_map = {}
    for m in re.finditer(r"IngredientAlias\(([^,]+),\s*([^)]+)\)\.", content):
        alias = safe_atom(m.group(1))
        canonical = safe_atom(m.group(2))
        if alias and canonical:
            alias_map[alias] = canonical
    return alias_map


def parse_nutrients_from_fact_text(content: str) -> dict[str, dict[str, float]]:
    nutrients = {}
    pattern = r"NutrientValuePer100g\(([^,]+),\s*([^,]+),\s*([^)]+)\)\."
    for m in re.finditer(pattern, content):
        ing = safe_atom(m.group(1))
        nutrient = safe_atom(m.group(2))
        raw_val = m.group(3).strip()
        try:
            value = float(raw_val)
        except ValueError:
            continue
        nutrients.setdefault(ing, {})[nutrient] = value
    return nutrients


def merge_nutrient_maps(
    base_map: dict[str, dict[str, float]], override_map: dict[str, dict[str, float]]
) -> dict[str, dict[str, float]]:
    merged = {ing: vals.copy() for ing, vals in base_map.items()}
    for ing, vals in override_map.items():
        merged.setdefault(ing, {})
        merged[ing].update(vals)
    return merged


def parse_allergens_from_fact_text(content: str) -> dict[str, set[str]]:
    allergen_map: dict[str, set[str]] = {}
    pattern = r"HasAllergen\(([^,]+),\s*([^)]+)\)\."
    for m in re.finditer(pattern, content):
        ing = safe_atom(m.group(1))
        allergen = safe_atom(m.group(2))
        if ing and allergen:
            allergen_map.setdefault(ing, set()).add(allergen)
    return allergen_map


@st.cache_resource(show_spinner=False)
def load_live_data() -> dict:
    recipes = []
    recipe_files = sorted(RECIPES_DIR.glob("*.json"))
    for path in recipe_files:
        with path.open("r", encoding="utf-8") as f:
            data = json.load(f)
        meals = data.get("meals") or []
        if not meals:
            continue
        meal = meals[0]
        display_name = (meal.get("strMeal") or path.stem).strip()
        recipes.append(
            {
                "id": safe_atom(display_name),
                "display_name": display_name,
                "ingredients": parse_meal_ingredients(meal),
                "instructions": meal.get("strInstructions") or "",
            }
        )

    nutrients_text = FACTS_NUTRIENTS.read_text(encoding="utf-8")
    overrides_text = FACTS_OVERRIDES.read_text(encoding="utf-8")
    allergens_text = FACTS_ALLERGENS.read_text(encoding="utf-8")
    base_nutrients = parse_nutrients_from_fact_text(nutrients_text)
    override_nutrients = parse_nutrients_from_fact_text(overrides_text)
    nutrients = merge_nutrient_maps(base_nutrients, override_nutrients)
    alias_map = parse_aliases_from_fact_text(overrides_text)
    allergen_map = parse_allergens_from_fact_text(allergens_text)
    rag_docs = [recipe_to_text(r) for r in recipes]
    return {
        "recipes": recipes,
        "nutrients": nutrients,
        "base_nutrients": base_nutrients,
        "override_nutrients": override_nutrients,
        "alias_map": alias_map,
        "allergen_map": allergen_map,
        "rag_docs": rag_docs,
    }


def resolve_nutrient_value(
    ingredient_atom: str, nutrient: str, nutrient_map: dict, alias_map: dict
) -> float | None:
    val = nutrient_map.get(ingredient_atom, {}).get(nutrient)
    if val is not None:
        return val
    alias = alias_map.get(ingredient_atom)
    if alias:
        return nutrient_map.get(alias, {}).get(nutrient)
    return None


def resolve_nutrient_hit(ingredient_atom: str, nutrient: str, data: dict) -> dict | None:
    alias_map = data["alias_map"]
    base_map = data["base_nutrients"]
    override_map = data["override_nutrients"]
    for candidate in expand_alias_candidates(ingredient_atom, alias_map):
        if nutrient in override_map.get(candidate, {}):
            return {
                "query_ingredient": ingredient_atom,
                "resolved_ingredient": candidate,
                "nutrient": nutrient,
                "value": float(override_map[candidate][nutrient]),
                "source_file": "facts_standardized_overrides.pl",
                "via_alias": candidate != ingredient_atom,
            }
        if nutrient in base_map.get(candidate, {}):
            return {
                "query_ingredient": ingredient_atom,
                "resolved_ingredient": candidate,
                "nutrient": nutrient,
                "value": float(base_map[candidate][nutrient]),
                "source_file": "facts_nutrients.pl",
                "via_alias": candidate != ingredient_atom,
            }
    return None


def expand_alias_candidates(ingredient_atom: str, alias_map: dict[str, str]) -> list[str]:
    candidates = [ingredient_atom]
    seen = {ingredient_atom}
    current = ingredient_atom
    while current in alias_map:
        nxt = alias_map[current]
        if not nxt or nxt in seen:
            break
        candidates.append(nxt)
        seen.add(nxt)
        current = nxt
    return candidates


def infer_nutrient_limit_query(question: str) -> tuple[str, str, float] | None:
    q = question.lower()
    nutrient = next((n for n in NUTRIENT_KEYS if n in q), None)
    if not nutrient:
        return None

    less_match = re.search(
        r"(?:less than|under|below|<=|at most|max(?:imum)?(?: of)?)\s*(\d+(?:\.\d+)?)",
        q,
    ) or re.search(rf"{nutrient}\s*(?:<|<=)\s*(\d+(?:\.\d+)?)", q)
    if less_match:
        return nutrient, "lt", float(less_match.group(1))

    greater_match = re.search(
        r"(?:more than|greater than|over|above|>=|at least|min(?:imum)?(?: of)?)\s*(\d+(?:\.\d+)?)",
        q,
    ) or re.search(rf"{nutrient}\s*(?:>|>=)\s*(\d+(?:\.\d+)?)", q)
    if greater_match:
        return nutrient, "gt", float(greater_match.group(1))

    return None


def infer_allergen_query(question: str) -> tuple[str, str] | None:
    q = question.lower()
    allergen = None
    for key, canonical in ALLERGEN_SYNONYMS.items():
        if key in q:
            allergen = canonical
            break
    if not allergen:
        return None

    if re.search(r"\b(without|free of|avoid|no)\b", q):
        return allergen, "without"
    if re.search(r"\b(with|contains?|include|including|have)\b", q):
        return allergen, "with"
    # Default to exclusion when user asks in allergen context without explicit connector
    return allergen, "without"


def fopc_answer_user_query(question: str, data: dict) -> dict:
    parsed = infer_nutrient_limit_query(question)
    allergen_parsed = infer_allergen_query(question)
    recipes = data["recipes"]
    nutrient_map = data["nutrients"]
    alias_map = data["alias_map"]
    allergen_map = data["allergen_map"]

    pyDatalog.clear()
    pyDatalog.create_terms("Uses, HasAllergen")
    for recipe in recipes:
        for ing in recipe["ingredients"]:
            pyDatalog.assert_fact("Uses", recipe["id"], ing["name_atom"])
    for ing_atom, allergens in allergen_map.items():
        for allergen in allergens:
            pyDatalog.assert_fact("HasAllergen", ing_atom, allergen)

    trace = {
        "query": question,
        "facts_used": [
            FACTS_NUTRIENTS.name,
            FACTS_OVERRIDES.name,
            FACTS_ALLERGENS.name,
        ],
        "mode": "unknown",
    }

    if parsed:
        nutrient, comparator, threshold = parsed
        trace["mode"] = "nutrient"
        trace["constraint"] = {
            "nutrient": nutrient,
            "comparator": comparator,
            "threshold": threshold,
        }
        candidates = []
        for recipe in recipes:
            total = 0.0
            evidence = []
            for ing in recipe["ingredients"]:
                atom = ing["name_atom"]
                # Actual FOPC-style lookups: Uses(recipe, ingredient) is queried via pyDatalog.
                if not pyDatalog.ask(f"Uses('{recipe['id']}', '{atom}')"):
                    continue
                hit = resolve_nutrient_hit(atom, nutrient, data)
                if hit is not None:
                    total += hit["value"]
                    evidence.append(hit)
            passes = total <= threshold if comparator == "lt" else total >= threshold
            if passes and total > 0:
                candidates.append(
                    {
                        "recipe": recipe["display_name"],
                        "total": round(total, 3),
                        "evidence": evidence[:8],
                    }
                )

        if not candidates:
            phrase = "less than or equal to" if comparator == "lt" else "greater than or equal to"
            return {
                "answer": (
                    f"No recipes found with total {nutrient} {phrase} {threshold} "
                    "using current facts."
                ),
                "trace": trace,
            }

        candidates.sort(key=lambda x: x["total"], reverse=(comparator == "gt"))
        top = candidates[:5]
        names = ", ".join(item["recipe"].lower() for item in top)
        values = ", ".join(str(item["total"]) for item in top)
        phrase = "at most" if comparator == "lt" else "at least"
        trace["top_recipes"] = top
        return {
            "answer": (
                f"You can make {names}, which have estimated total {nutrient} content "
                f"of {values} respectively ({phrase} {threshold})."
            ),
            "trace": trace,
        }

    if allergen_parsed:
        target_allergen, mode = allergen_parsed
        trace["mode"] = "allergen"
        trace["constraint"] = {"allergen": target_allergen, "mode": mode}
        candidates = []
        allergen_hits = {}
        for recipe in recipes:
            has_target = False
            hit_details = []
            for ing in recipe["ingredients"]:
                for atom in expand_alias_candidates(ing["name_atom"], alias_map):
                    if pyDatalog.ask(f"HasAllergen('{atom}', '{target_allergen}')"):
                        has_target = True
                        hit_details.append(
                            {
                                "query_ingredient": ing["name_atom"],
                                "resolved_ingredient": atom,
                                "allergen": target_allergen,
                                "source_file": "facts_allergens.pl",
                            }
                        )
                        break
                if has_target:
                    break
            if (mode == "without" and not has_target) or (mode == "with" and has_target):
                candidates.append(recipe["display_name"])
            if hit_details:
                allergen_hits[recipe["display_name"]] = hit_details

        if not candidates:
            qualifier = "without" if mode == "without" else "with"
            trace["allergen_hits"] = allergen_hits
            return {"answer": f"No recipes found {qualifier} {target_allergen}.", "trace": trace}

        sample = ", ".join(name.lower() for name in candidates[:8])
        qualifier = "without" if mode == "without" else "with"
        trace["allergen_hits"] = allergen_hits
        trace["matching_recipe_count"] = len(candidates)
        return {
            "answer": (
                f"Recipes {qualifier} {target_allergen}: {sample}. "
                f"Found {len(candidates)} matching recipes."
            ),
            "trace": trace,
        }

    # Recipe-intent mode for questions like "how do I make squash linguine?"
    if re.search(r"\b(how|make|cook|prepare)\b", question.lower()):
        matched_by_name = match_recipes_by_name(question, recipes, top_k=1)
        if matched_by_name:
            recipe = matched_by_name[0]
            ingredient_names = [x["name_raw"] for x in recipe["ingredients"]]
            short_steps = ". ".join(
                [s.strip() for s in re.split(r"[.!?]\s+", recipe["instructions"]) if s.strip()][:4]
            )
            trace["mode"] = "recipe_instruction"
            trace["recipe_match"] = recipe["display_name"]
            trace["facts_used"].append("italian_recipes_json/*.json")
            return {
                "answer": (
                    f"To make {recipe['display_name']}, use ingredients like "
                    f"{', '.join(ingredient_names[:8])}. "
                    f"Start with: {short_steps}."
                ),
                "trace": trace,
            }

    # Fallback mode: ingredient mention query
    q_words = query_terms(question)
    matched = []
    for recipe in recipes:
        ingredient_terms = set()
        for ing in recipe["ingredients"]:
            ingredient_terms.update(query_terms(ing["name_atom"].replace("_", " ")))
            ingredient_terms.update(query_terms(ing["name_raw"]))
            for alias in expand_alias_candidates(ing["name_atom"], alias_map):
                ingredient_terms.update(query_terms(alias.replace("_", " ")))
        if q_words.intersection(ingredient_terms):
            matched.append(recipe["display_name"])
    if matched:
        trace["mode"] = "ingredient"
        trace["matched_tokens"] = sorted(list(q_words))
        trace["matches"] = matched[:8]
        return {
            "answer": "Recipes matching mentioned ingredients: " + ", ".join(matched[:8]) + ".",
            "trace": trace,
        }
    trace["mode"] = "fallback"
    return {
        "answer": (
            "FOPC mode is live. Try nutrient-bound queries (e.g. fat less than 20) "
            "or allergen queries (e.g. recipes without gluten)."
        ),
        "trace": trace,
    }


def rag_retrieve(query: str, docs: list[str], k: int = 3) -> list[str]:
    q_words = re.findall(r"[a-zA-Z]+", query.lower())
    scored = []
    for i, text in enumerate(docs):
        t = text.lower()
        score = sum(1 for w in q_words if w in t)
        scored.append((score, i))
    scored.sort(reverse=True)
    return [docs[i] for score, i in scored[:k] if score > 0]


def build_prompt(query: str, contexts: list[str]) -> str:
    context_text = "\n\n".join(contexts)
    return f"""
You are a cooking assistant.

Answer the question using ONLY the recipe context below.

Context:
{context_text}

User Question:
{query}

Answer:
"""


def call_ollama(prompt: str) -> str:
    payload = {"model": "phi3", "prompt": prompt, "stream": False}
    r = requests.post("http://localhost:11434/api/generate", json=payload, timeout=120)
    r.raise_for_status()
    return r.json()["response"]


def ollama_is_available() -> bool:
    try:
        r = requests.get("http://localhost:11434/api/tags", timeout=2)
        return r.status_code == 200
    except Exception:
        return False


def plain_fallback_answer(query: str, data: dict) -> str:
    contexts = rag_retrieve(query, data["rag_docs"], k=4)
    if not contexts:
        return "I could not find relevant recipes in the local corpus for this question."
    parsed = [parse_rag_doc(c) for c in contexts]
    parsed = [p for p in parsed if p.get("recipe")]
    if not parsed:
        return (
            "Plain baseline fallback (no Ollama server): relevant recipe contexts were found, "
            "but could not be parsed into a full answer."
        )

    # If query asks "how to make X", prioritize strongest name match and return richer steps.
    name_matches = match_recipes_by_name(query, data["recipes"], top_k=1)
    if name_matches:
        chosen = name_matches[0]
        ingredient_names = [x["name_raw"] for x in chosen["ingredients"]]
        steps = [s.strip() for s in re.split(r"[.!?]\s+", chosen["instructions"]) if s.strip()][:6]
        step_text = "\n".join([f"{i+1}. {s}" for i, s in enumerate(steps)])
        return (
            f"Here is a detailed way to make **{chosen['display_name']}**:\n\n"
            f"**Ingredients (from dataset):** {', '.join(ingredient_names[:12])}\n\n"
            f"**Method:**\n{step_text}\n\n"
            "If you want, I can also adapt this into a quicker 20-minute version."
        )

    # General long-form fallback: summarize top retrieved recipes.
    lines = [
        "Ollama is currently unavailable, so this is a grounded long-form fallback from local recipe data.",
        "",
        "Here are relevant options:",
    ]
    for idx, item in enumerate(parsed[:3], start=1):
        steps = [s.strip() for s in re.split(r"[.!?]\s+", item["instructions"]) if s.strip()][:2]
        lines.append(f"{idx}. **{item['recipe']}**")
        if item["ingredients"]:
            lines.append(f"   - Ingredients: {item['ingredients'][:180]}")
        if steps:
            lines.append(f"   - Quick method: {'; '.join(steps)}.")
    lines.append("")
    lines.append("Tell me your dietary constraints and I can narrow this down further.")
    return "\n".join(lines)


def rag_answer_user_query(query: str, data: dict, k: int = 3) -> tuple[str, list[str], str]:
    contexts = rag_retrieve(query, data["rag_docs"], k=k)
    if not contexts:
        return "No relevant context found in recipe corpus.", [], "keyword"

    prompt = build_prompt(query, contexts)
    try:
        answer = call_ollama(prompt)
        return answer, contexts, "ollama+keyword"
    except Exception:
        # Grounded fallback when local model is not running.
        snippet = "\n\n".join(contexts[:2])
        return (
            "Ollama is unavailable, so this answer is context-grounded retrieval only.\n\n"
            + snippet[:1200],
            contexts,
            "keyword-only",
        )


def plain_answer_user_query(query: str, data: dict) -> tuple[str, str]:
    if ollama_is_available():
        try:
            return (
                call_ollama(f"You are a cooking assistant. Answer the user question.\n\n{query}"),
                "ollama",
            )
        except Exception:
            pass
    return plain_fallback_answer(query, data), "fallback"


def run_demo_query(query: str, include_rag: bool) -> dict:
    data = load_live_data()
    fopc_result = fopc_answer_user_query(query, data)
    plain_answer, plain_mode = plain_answer_user_query(query, data)
    result = {
        "query": query.strip(),
        "fopc_output": fopc_result["answer"],
        "fopc_trace": fopc_result["trace"],
        "plain_output": plain_answer,
        "plain_mode": plain_mode,
    }
    if include_rag:
        rag_answer, contexts, rag_mode = rag_answer_user_query(query, data)
        result["rag_output"] = rag_answer
        result["rag_contexts"] = contexts
        result["rag_mode"] = rag_mode
    return result


st.markdown(
    """
<style>
.main .block-container {padding-top: 1rem; padding-bottom: 2.4rem; max-width: 1240px;}
h1, h2, h3 {letter-spacing: -0.02em;}
[data-testid="stSidebar"] {border-right: 1px solid rgba(255,255,255,0.08);}
[data-testid="stSidebar"] > div:first-child {
  background: linear-gradient(180deg, rgba(42,47,79,0.55), rgba(12,16,32,0.2));
}
.hero-wrap {
  border-radius: 18px;
  border: 1px solid rgba(255,255,255,0.12);
  background:
    radial-gradient(circle at 8% 20%, rgba(91,124,250,0.35) 0%, rgba(20,20,40,0) 35%),
    radial-gradient(circle at 85% 30%, rgba(153,67,232,0.28) 0%, rgba(20,20,40,0) 35%),
    linear-gradient(135deg, rgba(18,24,44,0.88), rgba(14,18,34,0.88));
  padding: 1.35rem 1.4rem;
  box-shadow: 0 16px 40px rgba(0,0,0,0.28);
  margin-bottom: 1rem;
}
.hero-title {font-size: 1.55rem; font-weight: 700; margin: 0;}
.hero-sub {opacity: 0.88; margin-top: 0.35rem; font-size: 0.95rem;}
.pill {
  display: inline-block;
  margin-top: 0.7rem;
  margin-right: 0.35rem;
  border-radius: 999px;
  border: 1px solid rgba(255,255,255,0.2);
  padding: 0.18rem 0.6rem;
  font-size: 0.78rem;
  opacity: 0.95;
}
.metric-tile {
  border: 1px solid rgba(255,255,255,0.12);
  border-radius: 14px;
  padding: 0.75rem 0.8rem;
  background: linear-gradient(180deg, rgba(255,255,255,0.06), rgba(255,255,255,0.03));
}
.metric-label {font-size: 0.78rem; opacity: 0.85;}
.metric-value {font-size: 1.05rem; font-weight: 700; margin-top: 0.2rem;}
.section-card {
  border: 1px solid rgba(255,255,255,0.12);
  border-radius: 14px;
  padding: 0.7rem 0.9rem;
  background: linear-gradient(180deg, rgba(255,255,255,0.04), rgba(255,255,255,0.02));
}
</style>
""",
    unsafe_allow_html=True,
)

st.sidebar.markdown("## Control Center")
include_rag = st.sidebar.toggle("Enable RAG Output", value=True)
show_plain = st.sidebar.toggle("Show Plain Baseline", value=True)
st.sidebar.caption("Tip: Try nutrient constraints, allergen filters, or open-ended recipe questions.")

if "query_input" not in st.session_state:
    st.session_state["query_input"] = "Suggest Italian recipes with fat less than 20."
if "last_output" not in st.session_state:
    st.session_state["last_output"] = None

st.markdown(
    """
<div class="hero-wrap">
  <div class="hero-title">Culinary Reasoning Studio</div>
  <div class="hero-sub">A designer-style workspace for comparing symbolic FOPC reasoning, retrieval-augmented generation, and plain model behavior.</div>
  <span class="pill">FOPC facts</span>
  <span class="pill">RAG contexts</span>
  <span class="pill">Knowledge trace</span>
  <span class="pill">Live query compare</span>
</div>
""",
    unsafe_allow_html=True,
)

top_a, top_b, top_c = st.columns(3, gap="large")
with top_a:
    st.markdown(
        f"<div class='metric-tile'><div class='metric-label'>Recipes in corpus</div><div class='metric-value'>{len(load_live_data()['recipes'])}</div></div>",
        unsafe_allow_html=True,
    )
with top_b:
    st.markdown(
        f"<div class='metric-tile'><div class='metric-label'>RAG status</div><div class='metric-value'>{'Enabled' if include_rag else 'Disabled'}</div></div>",
        unsafe_allow_html=True,
    )
with top_c:
    st.markdown(
        f"<div class='metric-tile'><div class='metric-label'>Plain baseline</div><div class='metric-value'>{'Visible' if show_plain else 'Hidden'}</div></div>",
        unsafe_allow_html=True,
    )

tab_demo, tab_system = st.tabs(["Studio", "Architecture"])

with tab_demo:
    st.markdown("<div class='section-card'>", unsafe_allow_html=True)
    with st.form("query_form", clear_on_submit=False):
        st.markdown("### Query Composer")
        query = st.text_area(
            "Write your question",
            height=100,
            key="query_input",
            placeholder="e.g., Show recipes without gluten",
        )
        submitted = st.form_submit_button("Run Query", type="primary", use_container_width=True)
    st.markdown("</div>", unsafe_allow_html=True)

    if submitted:
        if not query.strip():
            st.warning("Please enter a query first.")
        else:
            st.session_state["last_output"] = run_demo_query(query, include_rag)
            st.success("Response generated.")

    output = st.session_state.get("last_output")

    if output:
        st.markdown(f"**Current prompt:** `{output['query']}`")
        if include_rag:
            col1, col2 = st.columns(2, gap="large")
            with col1:
                with st.container(border=True):
                    st.markdown("### FOPC Reasoning")
                    st.write(output["fopc_output"])
                    with st.expander("Knowledge trace"):
                        trace = output.get("fopc_trace", {})
                        st.markdown(f"- **Mode:** `{trace.get('mode', 'unknown')}`")
                        for item in trace.get("facts_used", []):
                            st.markdown(f"- **Fact source:** `{item}`")
                        if trace.get("constraint"):
                            st.markdown(f"- **Constraint parsed:** `{trace['constraint']}`")
                        for recipe_info in trace.get("top_recipes", []):
                            st.markdown(
                                f"- **Recipe:** `{recipe_info['recipe']}` total={recipe_info['total']}"
                            )
                            for ev in recipe_info.get("evidence", [])[:4]:
                                st.markdown(
                                    "  - "
                                    f"{ev['query_ingredient']} -> {ev['resolved_ingredient']} "
                                    f"{ev['nutrient']}={ev['value']} from `{ev['source_file']}`"
                                )
                        if trace.get("allergen_hits"):
                            for recipe_name, hits in list(trace["allergen_hits"].items())[:4]:
                                st.markdown(f"- **Allergen hit in:** `{recipe_name}`")
                                for hit in hits[:3]:
                                    st.markdown(
                                        "  - "
                                        f"{hit['query_ingredient']} -> {hit['resolved_ingredient']} "
                                        f"({hit['allergen']}) from `{hit['source_file']}`"
                                    )

            with col2:
                with st.container(border=True):
                    st.markdown("### RAG Generation")
                    st.write(output["rag_output"])
                    st.caption(f"RAG mode: `{output.get('rag_mode', 'unknown')}`")
                    with st.expander("Retrieved contexts"):
                        for i, ctx in enumerate(output.get("rag_contexts", []), start=1):
                            st.markdown(f"**Context {i}**")
                            st.code(ctx[:1200])
        else:
            with st.container(border=True):
                st.markdown("### FOPC Reasoning")
                st.write(output["fopc_output"])
                st.info("RAG output is disabled.")
                with st.expander("Knowledge trace"):
                    trace = output.get("fopc_trace", {})
                    st.markdown(f"- **Mode:** `{trace.get('mode', 'unknown')}`")
                    for item in trace.get("facts_used", []):
                        st.markdown(f"- **Fact source:** `{item}`")
                    if trace.get("constraint"):
                        st.markdown(f"- **Constraint parsed:** `{trace['constraint']}`")

        if show_plain:
            with st.container(border=True):
                st.markdown("### Plain Baseline")
                st.write(output["plain_output"])
                st.caption(f"Plain mode: `{output.get('plain_mode', 'unknown')}`")
    else:
        st.info("Run a query to see FOPC, RAG, and baseline results.")

with tab_system:
    st.markdown("### System Architecture")
    st.write(
        "This view summarizes the current repository architecture and how FOPC and RAG are produced."
    )
    for section, details in SYSTEM_MAP.items():
        with st.expander(section, expanded=True):
            for line in details:
                st.markdown(f"- {line}")

    st.markdown("### Pipeline Flow")
    st.markdown(
        """
        1. **Data Build (USDA + recipes)**: CSV and JSON ingestion.
        2. **FOPC Layer**: Facts are generated and queried using predicate logic.
        3. **RAG Layer**: Recipe docs are retrieved and passed to LLM context.
        4. **Comparison UI**: One query shows both outputs side-by-side.
        """
    )

    st.info(
        "This demo is wired to live recipe/fact files for FOPC-style querying and live RAG retrieval."
    )
