# KRR-project
# Dietary Constraint & Inventory-Aware Chef Agent

## Project Overview
This project aims to build an intelligent food recommendation agent that provides **strictly valid recipe suggestions** based on user dietary constraints and available ingredients. Unlike general Large Language Models (LLMs), which often approximate answers, this system guarantees correctness using structured knowledge and logical reasoning.

The agent recommends recipes only when all constraints are satisfied. If no recipe meets the requirements, the system explicitly reports that no valid option exists instead of suggesting approximations.

The system is currently focused on building a **reliable ingredient and nutrition knowledge base**, which will later be connected to recipe reasoning and agentic behavior.

---

## Motivation
Many recipe recommendation systems fail when users have rigid dietary needs, such as allergies, calorie limits, or ingredient availability constraints. LLMs often hallucinate ingredients or fail to enforce strict numerical requirements.

This project addresses those shortcomings by:
- Representing ingredient knowledge explicitly
- Using formal logical reasoning
- Performing deterministic nutrient calculations
- Providing transparent explanations

The goal is correctness and safety over creativity.

---

## Current Progress (Ingredient Knowledge Base)
At this stage, the system processes ingredient data and nutrition information using USDA FoodData Central datasets.

Completed pipeline:

1. USDA Foundation Foods dataset ingestion
2. Ingredient normalization and canonical mapping
3. Nutrient extraction per ingredient
4. Numeric aggregation per ingredient
5. Conversion to logical facts
6. Loading facts into a reasoning engine (pyDatalog)
7. Querying ingredient nutrient information

Example reasoning now possible:

- What nutrients does tomato contain?
- How many calories are in olive oil per 100g?
- Which ingredients contain protein?

---

## Knowledge Representation
Ingredients and nutrients are represented using First-Order Predicate Calculus (FOPC) style facts.

Example facts:
Ingredient(tomato).
HasNutrient(tomato, calories).
NutrientValuePer100g(tomato, calories, 18).

