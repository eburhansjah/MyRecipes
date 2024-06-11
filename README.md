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

- **Entity**: Users
  - **Fields**: user_id, first_name, last_name, email, created_on, user_type, and encrypted_password

- **Entity**: FreeUsers
  - **Fields**: user_id 

- **Entity**: PaidUsers
  - **Fields**: user_id
