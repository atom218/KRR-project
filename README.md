# KRR Project

Comparative culinary reasoning system that answers the same food query using:
- **FOPC-style symbolic reasoning** over structured facts
- **RAG retrieval + generation**
- **Plain LLM baseline** (with graceful local fallback)

The main deliverable is a Streamlit app (`demo_ui.py`) that lets users run one query and compare outputs side-by-side.

---

## What this project is

This repository implements a knowledge-driven recipe assistant focused on **deterministic dietary reasoning** and transparent output inspection.

Instead of relying only on free-form generation, the system:
- builds a fact layer from USDA + curated overrides,
- parses user constraints (nutrient bounds and allergens),
- performs symbolic checks per recipe/ingredient,
- and exposes a full trace of what data sources and facts were used.

The app is designed as a demo environment for evaluating symbolic + retrieval-based approaches together.

---

## Core capabilities

### 1) FOPC-style reasoning
- Parses questions such as:
  - "fat less than 20"
  - "protein over 30"
  - "recipes without gluten"
  - "how do I make squash linguine?"
- Uses generated fact files:
  - `facts_nutrients.pl`
  - `facts_standardized_overrides.pl`
  - `facts_allergens.pl`
- Resolves ingredient aliases before nutrient/allergen checks.
- Returns a **knowledge trace** with:
  - mode (`nutrient`, `allergen`, `recipe_instruction`, etc.)
  - parsed constraints
  - source fact files
  - evidence snippets per top recipe

### 2) RAG retrieval + answer
- Converts recipe JSON entries into text documents.
- Performs keyword-based retrieval over recipe docs.
- Builds a context prompt and calls local Ollama (`phi3`) when available.
- If Ollama is down, returns a retrieval-grounded fallback snippet.

### 3) Plain baseline
- Tries direct local Ollama generation first.
- If Ollama is unavailable, returns a richer local-data fallback answer.
- Useful for comparing "ungrounded generation vs symbolic traceable reasoning."

---

## Architecture overview

### Data sources
- `italian_recipes_json/*.json`  
  MealDB recipe corpus used for retrieval and display.
- `FoodData_Central_foundation_food_csv_2025-12-18/*.csv`  
  USDA nutrient/food source tables used in data build notebooks.
- Generated symbolic facts in `FoodData_Central_foundation_food_csv_2025-12-18/`:
  - `facts_ingredients.pl`
  - `facts_nutrients.pl`
  - `facts_standardized_overrides.pl`
  - `facts_allergens.pl`

### Runtime flow (`demo_ui.py`)
1. Load recipes and fact files (`load_live_data`).
2. Build nutrient/allergen/alias maps.
3. Parse user query into intent:
   - nutrient threshold, allergen filter, recipe-name intent, ingredient mention.
4. Run FOPC-style evaluation and collect trace.
5. Optionally run RAG retrieval + generation.
6. Optionally run plain baseline answer.
7. Render all outputs in Streamlit comparison cards.

---

## Repository map

- `demo_ui.py`  
  Main production demo app (Streamlit).
- `rag_llm.ipynb`  
  RAG prototyping notebook.
- `italian_mealdb_predicates.ipynb`  
  Recipe ingestion/predicate generation experiments.
- `FoodData_Central_foundation_food_csv_2025-12-18/ingredent FOPC.ipynb`  
  Fact-building and reasoning experiments.
- `FoodData_Central_foundation_food_csv_2025-12-18/query_comparison.ipynb`  
  Comparative FOPC/RAG/plain evaluation workflows.
- `FoodData_Central_foundation_food_csv_2025-12-18/recipe_fopc.ipynb`  
  Recipe-level symbolic experiments.
- `requirements.txt`  
  Minimal dependencies for current cloud-safe app runtime.

---

## Why symbolic + RAG comparison matters

Traditional LLM-only recommendation can hallucinate ingredients or ignore hard constraints.  
This project demonstrates a hybrid strategy:

- **FOPC-style layer** for strict, interpretable constraints.
- **RAG layer** for context-rich natural-language responses.
- **Plain baseline** to benchmark what unguided generation does.

The result is a clearer understanding of when each approach is strong or weak.

---

## Setup (local)

### Prerequisites
- Python 3.10+ recommended
- Optional: Ollama installed locally if you want live model generation

### Install
```bash
pip install -r requirements.txt
```

### Run
```bash
python -m streamlit run demo_ui.py
```

The app will open on localhost (usually `http://localhost:8501`).

---

## Ollama integration details

The app checks:
- `http://localhost:11434/api/tags` (health)
- `http://localhost:11434/api/generate` (generation)

Model used in current code:
- `phi3`

If Ollama is not available:
- RAG switches to keyword-context fallback mode.
- Plain baseline switches to local-data fallback mode.
- App still runs successfully.

---

## Streamlit Cloud deployment notes

This app is cloud-safe with current `requirements.txt`:
- `streamlit`
- `requests`

`pyDatalog` is treated as optional in `demo_ui.py`:
- If present locally, it is used.
- If absent (common in cloud builds), the app uses Python fact-index fallback.
- For current logic (direct fact membership checks), outputs should remain functionally consistent.

Important:
- Streamlit Cloud cannot access your local Ollama server.
- You will see fallback behavior unless you wire a cloud LLM provider.

---

## Query examples

Try:
- `Suggest Italian recipes with fat less than 20`
- `Show recipes without gluten`
- `Recipes with fish`
- `How do I make spaghetti carbonara?`
- `Show recipes with tomato and garlic`

---

## Current limitations

- Retrieval is keyword-based (not vector embeddings in the deployed app path).
- Nutrient aggregation is ingredient-based and depends on alias/override coverage.
- Allergen coverage is limited to encoded facts and synonym map.
- Local Ollama dependency for full generative output quality.

---

## Suggested next improvements

- Add cloud LLM backend via Streamlit secrets (OpenAI/Groq/etc.).
- Add embedding-based retrieval for stronger semantic matches.
- Expand fact coverage and rule depth (portion handling, unit normalization, multi-hop inference).
- Add automated test cases for expected FOPC outputs per query class.

---

## Goal of this repository

Provide a transparent, reproducible demo showing how symbolic reasoning and retrieval-augmented generation can be combined for safer, more controllable culinary QA under dietary constraints.

