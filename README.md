# MyRecipes Database
## Overview
A database for an app that saves and manages recipes across different platforms for the user’s personal usage. The app would be an all-in-one app for the user to manage recipes, and create meal plans. Aside from this, users would be able to look up the nutritional content of each recipe. There are two plans. Basic plans are free of charge, but are not free of advertisements. Premium plans would be free of advertisements.

The reason for doing so is because I have been handwriting online recipes, manually organizing, and creating meal plans on my tablet. That is why I would like to learn how I could develop a database that simplifies this process and potentially assist users to plan their meals. Such a database would also be useful for users to plan their next grocery visit, ensuring that they have gotten a proper amount of ingredients to minimize food waste.

## Full DBMS Physical ERD of the Database
<img width="957" alt="physical_DBMS_ERD" src="https://github.com/eburhansjah/MyRecipes/assets/130926828/e23db1ea-d771-473d-a4ed-522078dd6eae">

## Usecases and Fields
### I. Account signup/installation use case
The user downloads the application through the MyRecipes website or through the app store.
The downloaded application requires users to create an account if they are first-time users. 
The user enters their information to create an account which in turn will also be created in the database.
Users then select whether they want to be part of the premium plan. 

From the first use case, there are three entities that can be identified. They are Users, FreeUsers and Paid Users. FreeUsers and PaidUsers are entities formed from specialization relationships from user type.

### II. Recipe management use case
Users visit a website to look at recipes. To save a recipe in the app, users copy and paste the website’s URL. The app would automatically fill into a page that displays the details of this recipe according to the URL. If no match can be found from the URL into a text box, the app would provide suggestions on what to fill in. Users have the option to select what was suggested or select other options. Users have the option to select favorite recipes.

From the second use case, we can derive ten entities. One entity to record favorite recipes, eight entities dedicated for recipe and ingredient management, and one entity to keep track of nutritional information of the recipes. Aside from this we have two more entities that result from the specialization generalization relationship of recipe to food type.

### III. Meal plan management use case
To create a meal plan for the week, users are able to input which recipe they decide to make per day for different meal types e.g. breakfast, lunch, dinner, and snack.
From the third use case, we can derive four entities. 


## Trigger creation and usecase
A history table that would enable users to edit the information they have entered previously. Examples would be when users wish to have a different recipe name, change serving size of the recipe, cook time, and many more. 

If the user wishes to revert changes or to remove any information, they are allowed to do so as well because changes made will be recorded. Hence, the attributes that I have included are:
old_recipe_name, new_recipe_name, old_recipe_URL, new_recipe_URL, old_recipe_serving_size, new_recipe_serving_size, old_recipe_prep_time, new_recipe_prep_time, old_recipe_cook_time, new_recipe_cook_time, and change_date. 


