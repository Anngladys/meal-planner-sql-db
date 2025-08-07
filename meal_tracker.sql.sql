CREATE TABLE `FamilyMembers` (
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  `name` VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE `FoodPreferences` (
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  `member_id` INT,
  `food_type` VARCHAR(100),
  `preference_type` ENUM(like,dislike) NOT NULL
);

CREATE TABLE `Meals` (
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  `name` VARCHAR(100) UNIQUE NOT NULL,
  `meal_time` ENUM(Breakfast,Lunch,Dinner,Snack) NOT NULL
);

CREATE TABLE `MealPlans` (
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  `meal_id` INT,
  `plan_date` DATE NOT NULL,
  `member_id` INT
);

CREATE TABLE `Ingredients` (
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  `name` VARCHAR(100) UNIQUE NOT NULL,
  `quantity_unit` VARCHAR(50)
);

CREATE TABLE `MealIngredients` (
  `meal_id` INT,
  `ingredient_id` INT,
  `quantity` DECIMAL(10,2) NOT NULL
);

CREATE TABLE `GroceryList` (
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  `ingredient_id` INT,
  `planned_quantity` DECIMAL(10,2),
  `needed_by` DATE,
  `is_purchased` BOOLEAN DEFAULT false
);

ALTER TABLE `FamilyMembers` COMMENT = 'Stores info about each family member';

ALTER TABLE `FoodPreferences` COMMENT = 'Stores liked or disliked food types for each member';

ALTER TABLE `Meals` COMMENT = 'Defines planned meals';

ALTER TABLE `MealPlans` COMMENT = 'Links meals to specific family members on certain days';

ALTER TABLE `Ingredients` COMMENT = 'List of ingredients used in meals';

ALTER TABLE `MealIngredients` COMMENT = 'Many-to-many: Which ingredients go into which meals';

ALTER TABLE `GroceryList` COMMENT = 'Tracks what ingredients are needed and if they’ve been bought';

ALTER TABLE `FoodPreferences` ADD FOREIGN KEY (`member_id`) REFERENCES `FamilyMembers` (`id`);

ALTER TABLE `MealPlans` ADD FOREIGN KEY (`meal_id`) REFERENCES `Meals` (`id`);

ALTER TABLE `MealPlans` ADD FOREIGN KEY (`member_id`) REFERENCES `FamilyMembers` (`id`);

ALTER TABLE `MealIngredients` ADD FOREIGN KEY (`meal_id`) REFERENCES `Meals` (`id`);

ALTER TABLE `MealIngredients` ADD FOREIGN KEY (`ingredient_id`) REFERENCES `Ingredients` (`id`);

ALTER TABLE `GroceryList` ADD FOREIGN KEY (`ingredient_id`) REFERENCES `Ingredients` (`id`);
