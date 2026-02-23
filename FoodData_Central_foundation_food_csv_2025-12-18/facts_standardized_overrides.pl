% ============================
% MANUAL / STANDARDIZED INGREDIENT NUTRITION FACTS (per 100g)
% ============================

% ============================
% 1) CANONICAL INGREDIENTS (nutrient sources)
% ============================

% ---- Pasta: one standardized dry pasta profile ----
CanonicalIngredient(dry_pasta).
Ingredient(dry_pasta).
HasNutrient(dry_pasta, calories). NutrientValuePer100g(dry_pasta, calories, 371).
HasNutrient(dry_pasta, protein).  NutrientValuePer100g(dry_pasta, protein, 13).
HasNutrient(dry_pasta, fat).      NutrientValuePer100g(dry_pasta, fat, 1.5).
HasNutrient(dry_pasta, carbs).    NutrientValuePer100g(dry_pasta, carbs, 75).

% ---- Tomatoes: one standardized raw/canned tomato profile ----
CanonicalIngredient(tomatoes_std).
Ingredient(tomatoes_std).
HasNutrient(tomatoes_std, calories). NutrientValuePer100g(tomatoes_std, calories, 18).
HasNutrient(tomatoes_std, protein).  NutrientValuePer100g(tomatoes_std, protein, 0.9).
HasNutrient(tomatoes_std, fat).      NutrientValuePer100g(tomatoes_std, fat, 0.2).
HasNutrient(tomatoes_std, carbs).    NutrientValuePer100g(tomatoes_std, carbs, 3.9).

% ---- Tomato paste ----
CanonicalIngredient(tomato_paste_std).
Ingredient(tomato_paste_std).
HasNutrient(tomato_paste_std, calories). NutrientValuePer100g(tomato_paste_std, calories, 82).
HasNutrient(tomato_paste_std, protein).  NutrientValuePer100g(tomato_paste_std, protein, 4.3).
HasNutrient(tomato_paste_std, fat).      NutrientValuePer100g(tomato_paste_std, fat, 0.5).
HasNutrient(tomato_paste_std, carbs).    NutrientValuePer100g(tomato_paste_std, carbs, 19).

% ---- Tomato puree / passata ----
CanonicalIngredient(tomato_puree_std).
Ingredient(tomato_puree_std).
HasNutrient(tomato_puree_std, calories). NutrientValuePer100g(tomato_puree_std, calories, 38).
HasNutrient(tomato_puree_std, protein).  NutrientValuePer100g(tomato_puree_std, protein, 1.6).
HasNutrient(tomato_puree_std, fat).      NutrientValuePer100g(tomato_puree_std, fat, 0.2).
HasNutrient(tomato_puree_std, carbs).    NutrientValuePer100g(tomato_puree_std, carbs, 8).

% ---- Stocks (standardized) ----
CanonicalIngredient(beef_stock_std).
Ingredient(beef_stock_std).
HasNutrient(beef_stock_std, calories). NutrientValuePer100g(beef_stock_std, calories, 10).
HasNutrient(beef_stock_std, protein).  NutrientValuePer100g(beef_stock_std, protein, 1).
HasNutrient(beef_stock_std, fat).      NutrientValuePer100g(beef_stock_std, fat, 0.5).
HasNutrient(beef_stock_std, carbs).    NutrientValuePer100g(beef_stock_std, carbs, 0).

CanonicalIngredient(chicken_stock_std).
Ingredient(chicken_stock_std).
HasNutrient(chicken_stock_std, calories). NutrientValuePer100g(chicken_stock_std, calories, 8).
HasNutrient(chicken_stock_std, protein).  NutrientValuePer100g(chicken_stock_std, protein, 1).
HasNutrient(chicken_stock_std, fat).      NutrientValuePer100g(chicken_stock_std, fat, 0.3).
HasNutrient(chicken_stock_std, carbs).    NutrientValuePer100g(chicken_stock_std, carbs, 0).

CanonicalIngredient(vegetable_stock_std).
Ingredient(vegetable_stock_std).
HasNutrient(vegetable_stock_std, calories). NutrientValuePer100g(vegetable_stock_std, calories, 6).
HasNutrient(vegetable_stock_std, protein).  NutrientValuePer100g(vegetable_stock_std, protein, 0.5).
HasNutrient(vegetable_stock_std, fat).      NutrientValuePer100g(vegetable_stock_std, fat, 0).
HasNutrient(vegetable_stock_std, carbs).    NutrientValuePer100g(vegetable_stock_std, carbs, 1).

% Chicken stock cube (concentrated)
CanonicalIngredient(chicken_stock_cube_std).
Ingredient(chicken_stock_cube_std).
HasNutrient(chicken_stock_cube_std, calories). NutrientValuePer100g(chicken_stock_cube_std, calories, 240).
HasNutrient(chicken_stock_cube_std, protein).  NutrientValuePer100g(chicken_stock_cube_std, protein, 5).
HasNutrient(chicken_stock_cube_std, fat).      NutrientValuePer100g(chicken_stock_cube_std, fat, 15).
HasNutrient(chicken_stock_cube_std, carbs).    NutrientValuePer100g(chicken_stock_cube_std, carbs, 20).

% ---- Sauces/condiments (standardized) ----
CanonicalIngredient(worcestershire_sauce_std).
Ingredient(worcestershire_sauce_std).
HasNutrient(worcestershire_sauce_std, calories). NutrientValuePer100g(worcestershire_sauce_std, calories, 78).
HasNutrient(worcestershire_sauce_std, protein).  NutrientValuePer100g(worcestershire_sauce_std, protein, 0).
HasNutrient(worcestershire_sauce_std, fat).      NutrientValuePer100g(worcestershire_sauce_std, fat, 0).
HasNutrient(worcestershire_sauce_std, carbs).    NutrientValuePer100g(worcestershire_sauce_std, carbs, 19).

CanonicalIngredient(mustard_std).
Ingredient(mustard_std).
HasNutrient(mustard_std, calories). NutrientValuePer100g(mustard_std, calories, 66).
HasNutrient(mustard_std, protein).  NutrientValuePer100g(mustard_std, protein, 4).
HasNutrient(mustard_std, fat).      NutrientValuePer100g(mustard_std, fat, 4).
HasNutrient(mustard_std, carbs).    NutrientValuePer100g(mustard_std, carbs, 6).

CanonicalIngredient(vinegar_std).
Ingredient(vinegar_std).
HasNutrient(vinegar_std, calories). NutrientValuePer100g(vinegar_std, calories, 18).
HasNutrient(vinegar_std, protein).  NutrientValuePer100g(vinegar_std, protein, 0).
HasNutrient(vinegar_std, fat).      NutrientValuePer100g(vinegar_std, fat, 0).
HasNutrient(vinegar_std, carbs).    NutrientValuePer100g(vinegar_std, carbs, 0.04).

CanonicalIngredient(red_wine_vinegar_std).
Ingredient(red_wine_vinegar_std).
HasNutrient(red_wine_vinegar_std, calories). NutrientValuePer100g(red_wine_vinegar_std, calories, 18).
HasNutrient(red_wine_vinegar_std, protein).  NutrientValuePer100g(red_wine_vinegar_std, protein, 0).
HasNutrient(red_wine_vinegar_std, fat).      NutrientValuePer100g(red_wine_vinegar_std, fat, 0).
HasNutrient(red_wine_vinegar_std, carbs).    NutrientValuePer100g(red_wine_vinegar_std, carbs, 0.04).

CanonicalIngredient(soy_milk_std).
Ingredient(soy_milk_std).
HasNutrient(soy_milk_std, calories). NutrientValuePer100g(soy_milk_std, calories, 33).
HasNutrient(soy_milk_std, protein).  NutrientValuePer100g(soy_milk_std, protein, 3.3).
HasNutrient(soy_milk_std, fat).      NutrientValuePer100g(soy_milk_std, fat, 1.8).
HasNutrient(soy_milk_std, carbs).    NutrientValuePer100g(soy_milk_std, carbs, 0.6).

CanonicalIngredient(vegan_butter_std).
Ingredient(vegan_butter_std).
HasNutrient(vegan_butter_std, calories). NutrientValuePer100g(vegan_butter_std, calories, 717).
HasNutrient(vegan_butter_std, protein).  NutrientValuePer100g(vegan_butter_std, protein, 0).
HasNutrient(vegan_butter_std, fat).      NutrientValuePer100g(vegan_butter_std, fat, 81).
HasNutrient(vegan_butter_std, carbs).    NutrientValuePer100g(vegan_butter_std, carbs, 0).

% ---- Dairy & cheeses ----
CanonicalIngredient(parmigiano_reggiano_std).
Ingredient(parmigiano_reggiano_std).
HasNutrient(parmigiano_reggiano_std, calories). NutrientValuePer100g(parmigiano_reggiano_std, calories, 431).
HasNutrient(parmigiano_reggiano_std, protein).  NutrientValuePer100g(parmigiano_reggiano_std, protein, 38).
HasNutrient(parmigiano_reggiano_std, fat).      NutrientValuePer100g(parmigiano_reggiano_std, fat, 29).
HasNutrient(parmigiano_reggiano_std, carbs).    NutrientValuePer100g(parmigiano_reggiano_std, carbs, 4).

CanonicalIngredient(pecorino_std).
Ingredient(pecorino_std).
HasNutrient(pecorino_std, calories). NutrientValuePer100g(pecorino_std, calories, 387).
HasNutrient(pecorino_std, protein).  NutrientValuePer100g(pecorino_std, protein, 28).
HasNutrient(pecorino_std, fat).      NutrientValuePer100g(pecorino_std, fat, 32).
HasNutrient(pecorino_std, carbs).    NutrientValuePer100g(pecorino_std, carbs, 0).

CanonicalIngredient(mozzarella_balls_std).
Ingredient(mozzarella_balls_std).
HasNutrient(mozzarella_balls_std, calories). NutrientValuePer100g(mozzarella_balls_std, calories, 280).
HasNutrient(mozzarella_balls_std, protein).  NutrientValuePer100g(mozzarella_balls_std, protein, 28).
HasNutrient(mozzarella_balls_std, fat).      NutrientValuePer100g(mozzarella_balls_std, fat, 17).
HasNutrient(mozzarella_balls_std, carbs).    NutrientValuePer100g(mozzarella_balls_std, carbs, 3).

CanonicalIngredient(mascarpone_std).
Ingredient(mascarpone_std).
HasNutrient(mascarpone_std, calories). NutrientValuePer100g(mascarpone_std, calories, 429).
HasNutrient(mascarpone_std, protein).  NutrientValuePer100g(mascarpone_std, protein, 7).
HasNutrient(mascarpone_std, fat).      NutrientValuePer100g(mascarpone_std, fat, 44).
HasNutrient(mascarpone_std, carbs).    NutrientValuePer100g(mascarpone_std, carbs, 4).

CanonicalIngredient(creme_fraiche_std).
Ingredient(creme_fraiche_std).
HasNutrient(creme_fraiche_std, calories). NutrientValuePer100g(creme_fraiche_std, calories, 393).
HasNutrient(creme_fraiche_std, protein).  NutrientValuePer100g(creme_fraiche_std, protein, 2).
HasNutrient(creme_fraiche_std, fat).      NutrientValuePer100g(creme_fraiche_std, fat, 39).
HasNutrient(creme_fraiche_std, carbs).    NutrientValuePer100g(creme_fraiche_std, carbs, 3).

CanonicalIngredient(fromage_frais_std).
Ingredient(fromage_frais_std).
HasNutrient(fromage_frais_std, calories). NutrientValuePer100g(fromage_frais_std, calories, 80).
HasNutrient(fromage_frais_std, protein).  NutrientValuePer100g(fromage_frais_std, protein, 8).
HasNutrient(fromage_frais_std, fat).      NutrientValuePer100g(fromage_frais_std, fat, 4).
HasNutrient(fromage_frais_std, carbs).    NutrientValuePer100g(fromage_frais_std, carbs, 4).

% ---- Meat/seafood ----
CanonicalIngredient(minced_beef_std).
Ingredient(minced_beef_std).
HasNutrient(minced_beef_std, calories). NutrientValuePer100g(minced_beef_std, calories, 250).
HasNutrient(minced_beef_std, protein).  NutrientValuePer100g(minced_beef_std, protein, 26).
HasNutrient(minced_beef_std, fat).      NutrientValuePer100g(minced_beef_std, fat, 17).
HasNutrient(minced_beef_std, carbs).    NutrientValuePer100g(minced_beef_std, carbs, 0).

CanonicalIngredient(veal_std).
Ingredient(veal_std).
HasNutrient(veal_std, calories). NutrientValuePer100g(veal_std, calories, 172).
HasNutrient(veal_std, protein).  NutrientValuePer100g(veal_std, protein, 24).
HasNutrient(veal_std, fat).      NutrientValuePer100g(veal_std, fat, 8).
HasNutrient(veal_std, carbs).    NutrientValuePer100g(veal_std, carbs, 0).

CanonicalIngredient(bacon_std).
Ingredient(bacon_std).
HasNutrient(bacon_std, calories). NutrientValuePer100g(bacon_std, calories, 541).
HasNutrient(bacon_std, protein).  NutrientValuePer100g(bacon_std, protein, 37).
HasNutrient(bacon_std, fat).      NutrientValuePer100g(bacon_std, fat, 42).
HasNutrient(bacon_std, carbs).    NutrientValuePer100g(bacon_std, carbs, 1).

CanonicalIngredient(chicken_breasts_std).
Ingredient(chicken_breasts_std).
HasNutrient(chicken_breasts_std, calories). NutrientValuePer100g(chicken_breasts_std, calories, 165).
HasNutrient(chicken_breasts_std, protein).  NutrientValuePer100g(chicken_breasts_std, protein, 31).
HasNutrient(chicken_breasts_std, fat).      NutrientValuePer100g(chicken_breasts_std, fat, 3.6).
HasNutrient(chicken_breasts_std, carbs).    NutrientValuePer100g(chicken_breasts_std, carbs, 0).

CanonicalIngredient(italian_fennel_sausages_std).
Ingredient(italian_fennel_sausages_std).
HasNutrient(italian_fennel_sausages_std, calories). NutrientValuePer100g(italian_fennel_sausages_std, calories, 300).
HasNutrient(italian_fennel_sausages_std, protein).  NutrientValuePer100g(italian_fennel_sausages_std, protein, 17).
HasNutrient(italian_fennel_sausages_std, fat).      NutrientValuePer100g(italian_fennel_sausages_std, fat, 25).
HasNutrient(italian_fennel_sausages_std, carbs).    NutrientValuePer100g(italian_fennel_sausages_std, carbs, 2).

CanonicalIngredient(anchovy_fillet_std).
Ingredient(anchovy_fillet_std).
HasNutrient(anchovy_fillet_std, calories). NutrientValuePer100g(anchovy_fillet_std, calories, 210).
HasNutrient(anchovy_fillet_std, protein).  NutrientValuePer100g(anchovy_fillet_std, protein, 29).
HasNutrient(anchovy_fillet_std, fat).      NutrientValuePer100g(anchovy_fillet_std, fat, 10).
HasNutrient(anchovy_fillet_std, carbs).    NutrientValuePer100g(anchovy_fillet_std, carbs, 0).

CanonicalIngredient(king_prawns_std).
Ingredient(king_prawns_std).
HasNutrient(king_prawns_std, calories). NutrientValuePer100g(king_prawns_std, calories, 99).
HasNutrient(king_prawns_std, protein).  NutrientValuePer100g(king_prawns_std, protein, 24).
HasNutrient(king_prawns_std, fat).      NutrientValuePer100g(king_prawns_std, fat, 0.3).
HasNutrient(king_prawns_std, carbs).    NutrientValuePer100g(king_prawns_std, carbs, 0).

CanonicalIngredient(pilchards_std).
Ingredient(pilchards_std).
HasNutrient(pilchards_std, calories). NutrientValuePer100g(pilchards_std, calories, 208).
HasNutrient(pilchards_std, protein).  NutrientValuePer100g(pilchards_std, protein, 24).
HasNutrient(pilchards_std, fat).      NutrientValuePer100g(pilchards_std, fat, 11).
HasNutrient(pilchards_std, carbs).    NutrientValuePer100g(pilchards_std, carbs, 0).

% ---- Vegetables / beans / grains / sugars / olives ----
CanonicalIngredient(carrots_std).
Ingredient(carrots_std).
HasNutrient(carrots_std, calories). NutrientValuePer100g(carrots_std, calories, 41).
HasNutrient(carrots_std, protein).  NutrientValuePer100g(carrots_std, protein, 0.9).
HasNutrient(carrots_std, fat).      NutrientValuePer100g(carrots_std, fat, 0.2).
HasNutrient(carrots_std, carbs).    NutrientValuePer100g(carrots_std, carbs, 10).

CanonicalIngredient(celery_std).
Ingredient(celery_std).
HasNutrient(celery_std, calories). NutrientValuePer100g(celery_std, calories, 16).
HasNutrient(celery_std, protein).  NutrientValuePer100g(celery_std, protein, 0.7).
HasNutrient(celery_std, fat).      NutrientValuePer100g(celery_std, fat, 0.2).
HasNutrient(celery_std, carbs).    NutrientValuePer100g(celery_std, carbs, 3).

CanonicalIngredient(mushrooms_std).
Ingredient(mushrooms_std).
HasNutrient(mushrooms_std, calories). NutrientValuePer100g(mushrooms_std, calories, 22).
HasNutrient(mushrooms_std, protein).  NutrientValuePer100g(mushrooms_std, protein, 3.1).
HasNutrient(mushrooms_std, fat).      NutrientValuePer100g(mushrooms_std, fat, 0.3).
HasNutrient(mushrooms_std, carbs).    NutrientValuePer100g(mushrooms_std, carbs, 3).

CanonicalIngredient(potatoes_std).
Ingredient(potatoes_std).
HasNutrient(potatoes_std, calories). NutrientValuePer100g(potatoes_std, calories, 77).
HasNutrient(potatoes_std, protein).  NutrientValuePer100g(potatoes_std, protein, 2).
HasNutrient(potatoes_std, fat).      NutrientValuePer100g(potatoes_std, fat, 0.1).
HasNutrient(potatoes_std, carbs).    NutrientValuePer100g(potatoes_std, carbs, 17).

CanonicalIngredient(lettuce_std).
Ingredient(lettuce_std).
HasNutrient(lettuce_std, calories). NutrientValuePer100g(lettuce_std, calories, 15).
HasNutrient(lettuce_std, protein).  NutrientValuePer100g(lettuce_std, protein, 1.4).
HasNutrient(lettuce_std, fat).      NutrientValuePer100g(lettuce_std, fat, 0.2).
HasNutrient(lettuce_std, carbs).    NutrientValuePer100g(lettuce_std, carbs, 2.9).

CanonicalIngredient(asparagus_std).
Ingredient(asparagus_std).
HasNutrient(asparagus_std, calories). NutrientValuePer100g(asparagus_std, calories, 20).
HasNutrient(asparagus_std, protein).  NutrientValuePer100g(asparagus_std, protein, 2.2).
HasNutrient(asparagus_std, fat).      NutrientValuePer100g(asparagus_std, fat, 0.1).
HasNutrient(asparagus_std, carbs).    NutrientValuePer100g(asparagus_std, carbs, 4).

CanonicalIngredient(fennel_bulb_std).
Ingredient(fennel_bulb_std).
HasNutrient(fennel_bulb_std, calories). NutrientValuePer100g(fennel_bulb_std, calories, 31).
HasNutrient(fennel_bulb_std, protein).  NutrientValuePer100g(fennel_bulb_std, protein, 1.2).
HasNutrient(fennel_bulb_std, fat).      NutrientValuePer100g(fennel_bulb_std, fat, 0.2).
HasNutrient(fennel_bulb_std, carbs).    NutrientValuePer100g(fennel_bulb_std, carbs, 7).

CanonicalIngredient(snap_peas_std).
Ingredient(snap_peas_std).
HasNutrient(snap_peas_std, calories). NutrientValuePer100g(snap_peas_std, calories, 42).
HasNutrient(snap_peas_std, protein).  NutrientValuePer100g(snap_peas_std, protein, 2.8).
HasNutrient(snap_peas_std, fat).      NutrientValuePer100g(snap_peas_std, fat, 0.2).
HasNutrient(snap_peas_std, carbs).    NutrientValuePer100g(snap_peas_std, carbs, 7.5).

CanonicalIngredient(onion_std).
Ingredient(onion_std).
HasNutrient(onion_std, calories). NutrientValuePer100g(onion_std, calories, 40).
HasNutrient(onion_std, protein).  NutrientValuePer100g(onion_std, protein, 1.1).
HasNutrient(onion_std, fat).      NutrientValuePer100g(onion_std, fat, 0.1).
HasNutrient(onion_std, carbs).    NutrientValuePer100g(onion_std, carbs, 9).

CanonicalIngredient(cannellini_beans_std).
Ingredient(cannellini_beans_std).
HasNutrient(cannellini_beans_std, calories). NutrientValuePer100g(cannellini_beans_std, calories, 139).
HasNutrient(cannellini_beans_std, protein).  NutrientValuePer100g(cannellini_beans_std, protein, 9).
HasNutrient(cannellini_beans_std, fat).      NutrientValuePer100g(cannellini_beans_std, fat, 0.6).
HasNutrient(cannellini_beans_std, carbs).    NutrientValuePer100g(cannellini_beans_std, carbs, 25).

CanonicalIngredient(rice_std).
Ingredient(rice_std).
HasNutrient(rice_std, calories). NutrientValuePer100g(rice_std, calories, 365).
HasNutrient(rice_std, protein).  NutrientValuePer100g(rice_std, protein, 7).
HasNutrient(rice_std, fat).      NutrientValuePer100g(rice_std, fat, 0.6).
HasNutrient(rice_std, carbs).    NutrientValuePer100g(rice_std, carbs, 80).

CanonicalIngredient(bread_white_std).
Ingredient(bread_white_std).
HasNutrient(bread_white_std, calories). NutrientValuePer100g(bread_white_std, calories, 265).
HasNutrient(bread_white_std, protein).  NutrientValuePer100g(bread_white_std, protein, 9).
HasNutrient(bread_white_std, fat).      NutrientValuePer100g(bread_white_std, fat, 3.2).
HasNutrient(bread_white_std, carbs).    NutrientValuePer100g(bread_white_std, carbs, 49).

CanonicalIngredient(wholegrain_bread_std).
Ingredient(wholegrain_bread_std).
HasNutrient(wholegrain_bread_std, calories). NutrientValuePer100g(wholegrain_bread_std, calories, 247).
HasNutrient(wholegrain_bread_std, protein).  NutrientValuePer100g(wholegrain_bread_std, protein, 13).
HasNutrient(wholegrain_bread_std, fat).      NutrientValuePer100g(wholegrain_bread_std, fat, 4).
HasNutrient(wholegrain_bread_std, carbs).    NutrientValuePer100g(wholegrain_bread_std, carbs, 41).

CanonicalIngredient(sugar_std).
Ingredient(sugar_std).
HasNutrient(sugar_std, calories). NutrientValuePer100g(sugar_std, calories, 387).
HasNutrient(sugar_std, protein).  NutrientValuePer100g(sugar_std, protein, 0).
HasNutrient(sugar_std, fat).      NutrientValuePer100g(sugar_std, fat, 0).
HasNutrient(sugar_std, carbs).    NutrientValuePer100g(sugar_std, carbs, 100).

CanonicalIngredient(honey_std).
Ingredient(honey_std).
HasNutrient(honey_std, calories). NutrientValuePer100g(honey_std, calories, 304).
HasNutrient(honey_std, protein).  NutrientValuePer100g(honey_std, protein, 0).
HasNutrient(honey_std, fat).      NutrientValuePer100g(honey_std, fat, 0).
HasNutrient(honey_std, carbs).    NutrientValuePer100g(honey_std, carbs, 82).

CanonicalIngredient(olives_std).
Ingredient(olives_std).
HasNutrient(olives_std, calories). NutrientValuePer100g(olives_std, calories, 145).
HasNutrient(olives_std, protein).  NutrientValuePer100g(olives_std, protein, 1).
HasNutrient(olives_std, fat).      NutrientValuePer100g(olives_std, fat, 15).
HasNutrient(olives_std, carbs).    NutrientValuePer100g(olives_std, carbs, 4).

CanonicalIngredient(garlic_clove_std).
Ingredient(garlic_clove_std).
HasNutrient(garlic_clove_std, calories). NutrientValuePer100g(garlic_clove_std, calories, 149).
HasNutrient(garlic_clove_std, protein).  NutrientValuePer100g(garlic_clove_std, protein, 6.4).
HasNutrient(garlic_clove_std, fat).      NutrientValuePer100g(garlic_clove_std, fat, 0.5).
HasNutrient(garlic_clove_std, carbs).    NutrientValuePer100g(garlic_clove_std, carbs, 33).

CanonicalIngredient(egg_yolks_std).
Ingredient(egg_yolks_std).
HasNutrient(egg_yolks_std, calories). NutrientValuePer100g(egg_yolks_std, calories, 322).
HasNutrient(egg_yolks_std, protein).  NutrientValuePer100g(egg_yolks_std, protein, 16).
HasNutrient(egg_yolks_std, fat).      NutrientValuePer100g(egg_yolks_std, fat, 27).
HasNutrient(egg_yolks_std, carbs).    NutrientValuePer100g(egg_yolks_std, carbs, 4).

% Wines / spirits (standardized)
CanonicalIngredient(wine_std).
Ingredient(wine_std).
HasNutrient(wine_std, calories). NutrientValuePer100g(wine_std, calories, 85).
HasNutrient(wine_std, protein).  NutrientValuePer100g(wine_std, protein, 0).
HasNutrient(wine_std, fat).      NutrientValuePer100g(wine_std, fat, 0).
HasNutrient(wine_std, carbs).    NutrientValuePer100g(wine_std, carbs, 2.6).

CanonicalIngredient(dark_rum_std).
Ingredient(dark_rum_std).
HasNutrient(dark_rum_std, calories). NutrientValuePer100g(dark_rum_std, calories, 231).
HasNutrient(dark_rum_std, protein).  NutrientValuePer100g(dark_rum_std, protein, 0).
HasNutrient(dark_rum_std, fat).      NutrientValuePer100g(dark_rum_std, fat, 0).
HasNutrient(dark_rum_std, carbs).    NutrientValuePer100g(dark_rum_std, carbs, 0).

% ============================
% 2) ALIASES (what counts as the same standardized ingredient)
%    IMPORTANT: We also declare Ingredient(alias) so queries never “miss”.
% ============================

% ---- Pastas ----
Ingredient(spaghetti).        IngredientAlias(spaghetti, dry_pasta).
Ingredient(penne).            IngredientAlias(penne, dry_pasta).
Ingredient(rigatoni).         IngredientAlias(rigatoni, dry_pasta).
Ingredient(paccheri_pasta).   IngredientAlias(paccheri_pasta, dry_pasta).
Ingredient(linguine_pasta).   IngredientAlias(linguine_pasta, dry_pasta).
Ingredient(farfalle).         IngredientAlias(farfalle, dry_pasta).
Ingredient(bowtie_pasta).     IngredientAlias(bowtie_pasta, dry_pasta).
Ingredient(lasagna_noodles).  IngredientAlias(lasagna_noodles, dry_pasta).

% ---- Tomato variants ----
Ingredient(tomatoes).            IngredientAlias(tomatoes, tomatoes_std).
Ingredient(chopped_tomatoes).    IngredientAlias(chopped_tomatoes, tomatoes_std).
Ingredient(cherry_tomatoes).     IngredientAlias(cherry_tomatoes, tomatoes_std).
Ingredient(baby_plum_tomatoes).  IngredientAlias(baby_plum_tomatoes, tomatoes_std).

Ingredient(tomato_paste).        IngredientAlias(tomato_paste, tomato_paste_std).
Ingredient(tomato_puree).        IngredientAlias(tomato_puree, tomato_puree_std).
Ingredient(tomato_puree).        IngredientAlias(tomato_puree, tomato_puree_std).
Ingredient(passata).             IngredientAlias(passata, tomato_puree_std).

% ---- Stocks / cubes ----
Ingredient(beef_stock).          IngredientAlias(beef_stock, beef_stock_std).
Ingredient(chicken_stock).       IngredientAlias(chicken_stock, chicken_stock_std).
Ingredient(vegetable_stock).     IngredientAlias(vegetable_stock, vegetable_stock_std).
Ingredient(chicken_stock_cube).  IngredientAlias(chicken_stock_cube, chicken_stock_cube_std).

% ---- Condiments ----
Ingredient(worcestershire_sauce). IngredientAlias(worcestershire_sauce, worcestershire_sauce_std).
Ingredient(mustard).              IngredientAlias(mustard, mustard_std).
Ingredient(vinegar).              IngredientAlias(vinegar, vinegar_std).
Ingredient(red_wine_vinegar).     IngredientAlias(red_wine_vinegar, red_wine_vinegar_std).

% ---- Dairy / cheese ----
Ingredient(parmigiano_reggiano). IngredientAlias(parmigiano_reggiano, parmigiano_reggiano_std).
Ingredient(pecorino).            IngredientAlias(pecorino, pecorino_std).
Ingredient(pecorino_cheese).     IngredientAlias(pecorino_cheese, pecorino_std).
Ingredient(mozzarella_balls).    IngredientAlias(mozzarella_balls, mozzarella_balls_std).
Ingredient(mascarpone).          IngredientAlias(mascarpone, mascarpone_std).
Ingredient(creme_fraiche).       IngredientAlias(creme_fraiche, creme_fraiche_std).
Ingredient(fromage_frais).       IngredientAlias(fromage_frais, fromage_frais_std).

% ---- Plant-based ----
Ingredient(soy_milk).           IngredientAlias(soy_milk, soy_milk_std).
Ingredient(vegan_butter).       IngredientAlias(vegan_butter, vegan_butter_std).

% ---- Meats/seafood ----
Ingredient(minced_beef).             IngredientAlias(minced_beef, minced_beef_std).
Ingredient(veal).                    IngredientAlias(veal, veal_std).
Ingredient(bacon).                   IngredientAlias(bacon, bacon_std).
Ingredient(chicken_breasts).         IngredientAlias(chicken_breasts, chicken_breasts_std).
Ingredient(italian_fennel_sausages). IngredientAlias(italian_fennel_sausages, italian_fennel_sausages_std).
Ingredient(anchovy_fillet).          IngredientAlias(anchovy_fillet, anchovy_fillet_std).
Ingredient(king_prawns).             IngredientAlias(king_prawns, king_prawns_std).
Ingredient(pilchards).               IngredientAlias(pilchards, pilchards_std).

% ---- Veg / grains / beans / sugars / olives ----
Ingredient(carrots).          IngredientAlias(carrots, carrots_std).
Ingredient(celery).           IngredientAlias(celery, celery_std).
Ingredient(mushrooms).        IngredientAlias(mushrooms, mushrooms_std).
Ingredient(potatoes).         IngredientAlias(potatoes, potatoes_std).
Ingredient(lettuce).          IngredientAlias(lettuce, lettuce_std).
Ingredient(asparagus).        IngredientAlias(asparagus, asparagus_std).
Ingredient(fennel_bulb).      IngredientAlias(fennel_bulb, fennel_bulb_std).
Ingredient(fennel).           IngredientAlias(fennel, fennel_bulb_std).

Ingredient(snap_peas).        IngredientAlias(snap_peas, snap_peas_std).
Ingredient(sugar_snap_peas).  IngredientAlias(sugar_snap_peas, snap_peas_std).

Ingredient(onions).           IngredientAlias(onions, onion_std).
Ingredient(red_onions).       IngredientAlias(red_onions, onion_std).

Ingredient(cannellini_beans). IngredientAlias(cannellini_beans, cannellini_beans_std).

Ingredient(rice).             IngredientAlias(rice, rice_std).

Ingredient(bread).            IngredientAlias(bread, bread_white_std).
Ingredient(wholegrain_bread). IngredientAlias(wholegrain_bread, wholegrain_bread_std).

Ingredient(caster_sugar).     IngredientAlias(caster_sugar, sugar_std).
Ingredient(icing_sugar).      IngredientAlias(icing_sugar, sugar_std).

Ingredient(honey).            IngredientAlias(honey, honey_std).

Ingredient(green_olives).     IngredientAlias(green_olives, olives_std).
Ingredient(black_olives).     IngredientAlias(black_olives, olives_std).

Ingredient(garlic_clove).     IngredientAlias(garlic_clove, garlic_clove_std).

Ingredient(egg_yolks).        IngredientAlias(egg_yolks, egg_yolks_std).

% ---- Wine / spirits ----
Ingredient(white_wine).       IngredientAlias(white_wine, wine_std).
Ingredient(dry_white_wine).   IngredientAlias(dry_white_wine, wine_std).
Ingredient(red_wine).         IngredientAlias(red_wine, wine_std).
Ingredient(dark_rum).         IngredientAlias(dark_rum, dark_rum_std).

% ============================
% 3) "Ignored" herbs/seasonings (to avoid missing ingredient errors)
%    We encode them but set macros to 0.
% ============================

CanonicalIngredient(ignored_seasoning_std).
Ingredient(ignored_seasoning_std).
HasNutrient(ignored_seasoning_std, calories). NutrientValuePer100g(ignored_seasoning_std, calories, 0).
HasNutrient(ignored_seasoning_std, protein).  NutrientValuePer100g(ignored_seasoning_std, protein, 0).
HasNutrient(ignored_seasoning_std, fat).      NutrientValuePer100g(ignored_seasoning_std, fat, 0).
HasNutrient(ignored_seasoning_std, carbs).    NutrientValuePer100g(ignored_seasoning_std, carbs, 0).

IgnoredIngredient(oregano).            Ingredient(oregano).            IngredientAlias(oregano, ignored_seasoning_std).
IgnoredIngredient(basil).              Ingredient(basil).              IngredientAlias(basil, ignored_seasoning_std).
IgnoredIngredient(thyme).              Ingredient(thyme).              IngredientAlias(thyme, ignored_seasoning_std).
IgnoredIngredient(parsley).            Ingredient(parsley).            IngredientAlias(parsley, ignored_seasoning_std).
IgnoredIngredient(marjoram).           Ingredient(marjoram).           IngredientAlias(marjoram, ignored_seasoning_std).
IgnoredIngredient(rosemary).           Ingredient(rosemary).           IngredientAlias(rosemary, ignored_seasoning_std).
IgnoredIngredient(sage).               Ingredient(sage).               IngredientAlias(sage, ignored_seasoning_std).
IgnoredIngredient(bay_leaves).         Ingredient(bay_leaves).         IngredientAlias(bay_leaves, ignored_seasoning_std).
IgnoredIngredient(nutmeg).             Ingredient(nutmeg).             IngredientAlias(nutmeg, ignored_seasoning_std).
IgnoredIngredient(black_pepper).        Ingredient(black_pepper).        IngredientAlias(black_pepper, ignored_seasoning_std).
IgnoredIngredient(italian_seasoning).  Ingredient(italian_seasoning).  IngredientAlias(italian_seasoning, ignored_seasoning_std).
IgnoredIngredient(fennel_seeds).       Ingredient(fennel_seeds).       IngredientAlias(fennel_seeds, ignored_seasoning_std).
IgnoredIngredient(smoky_paprika).      Ingredient(smoky_paprika).      IngredientAlias(smoky_paprika, ignored_seasoning_std).

IgnoredIngredient(orange_zest).        Ingredient(orange_zest).        IngredientAlias(orange_zest, ignored_seasoning_std).
IgnoredIngredient(lemon_zest).         Ingredient(lemon_zest).         IngredientAlias(lemon_zest, ignored_seasoning_std).

IgnoredIngredient(red_chilli_flake).   Ingredient(red_chilli_flake).   IngredientAlias(red_chilli_flake, ignored_seasoning_std).
IgnoredIngredient(red_chilli_flakes).  Ingredient(red_chilli_flakes).  IngredientAlias(red_chilli_flakes, ignored_seasoning_std).
IgnoredIngredient(red_chili_flake).    Ingredient(red_chili_flake).    IngredientAlias(red_chili_flake, ignored_seasoning_std).

IgnoredIngredient(water).              Ingredient(water).              IngredientAlias(water, ignored_seasoning_std).

% ============================
% 4) Misc items that appear in your list but weren’t assigned above
%    (Add minimal safe encodings so they never crash)
% ============================

% Yeast can vary; standardize lightly
CanonicalIngredient(yeast_std).
Ingredient(yeast_std).
HasNutrient(yeast_std, calories). NutrientValuePer100g(yeast_std, calories, 325).
HasNutrient(yeast_std, protein).  NutrientValuePer100g(yeast_std, protein, 40).
HasNutrient(yeast_std, fat).      NutrientValuePer100g(yeast_std, fat, 7).
HasNutrient(yeast_std, carbs).    NutrientValuePer100g(yeast_std, carbs, 41).
Ingredient(yeast). IngredientAlias(yeast, yeast_std).

% Lemon / lime: treat same
CanonicalIngredient(citrus_std).
Ingredient(citrus_std).
HasNutrient(citrus_std, calories). NutrientValuePer100g(citrus_std, calories, 29).
HasNutrient(citrus_std, protein).  NutrientValuePer100g(citrus_std, protein, 1).
HasNutrient(citrus_std, fat).      NutrientValuePer100g(citrus_std, fat, 0.3).
HasNutrient(citrus_std, carbs).    NutrientValuePer100g(citrus_std, carbs, 9).
Ingredient(lemon). IngredientAlias(lemon, citrus_std).
Ingredient(lime).  IngredientAlias(lime, citrus_std).
