-- ----------------------------------------
-- Meal Planning & Grocery Tracker Database
-- ----------------------------------------

-- Drop existing tables if rerunning this script
DROP TABLE IF EXISTS grocery_list, pantry_stock, recipe_ingredients, recipes, meals, family_profiles, ingredients, users;

-- -------------------
-- USERS Table
-- -------------------
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);

-- -------------------
-- FAMILY PROFILES
-- -------------------
CREATE TABLE family_profiles (
    profile_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    name VARCHAR(100) NOT NULL,
    food_preferences TEXT,
    notes TEXT,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- -------------------
-- INGREDIENTS
-- -------------------
CREATE TABLE ingredients (
    ingredient_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    unit VARCHAR(20) -- e.g., grams, ml, pieces
);

-- -------------------
-- RECIPES
-- -------------------
CREATE TABLE recipes (
    recipe_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    name VARCHAR(100) NOT NULL,
    instructions TEXT,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- -------------------
-- RECIPE INGREDIENTS (Many-to-Many)
-- -------------------
CREATE TABLE recipe_ingredients (
    recipe_id INT,
    ingredient_id INT,
    quantity DECIMAL(6,2),
    PRIMARY KEY (recipe_id, ingredient_id),
    FOREIGN KEY (recipe_id) REFERENCES recipes(recipe_id),
    FOREIGN KEY (ingredient_id) REFERENCES ingredients(ingredient_id)
);

-- -------------------
-- MEALS
-- -------------------
CREATE TABLE meals (
    meal_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    recipe_id INT,
    meal_date DATE NOT NULL,
    meal_type ENUM('Breakfast', 'Lunch', 'Dinner', 'Snack') NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (recipe_id) REFERENCES recipes(recipe_id)
);

-- -------------------
-- PANTRY STOCK
-- -------------------
CREATE TABLE pantry_stock (
    stock_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    ingredient_id INT NOT NULL,
    quantity DECIMAL(6,2),
    expiry_date DATE,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (ingredient_id) REFERENCES ingredients(ingredient_id)
);

-- -------------------
-- GROCERY LIST
-- -------------------
CREATE TABLE grocery_list (
    item_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    ingredient_id INT NOT NULL,
    quantity DECIMAL(6,2),
    needed_by DATE,
    is_purchased BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (ingredient_id) REFERENCES ingredients(ingredient_id)
);
