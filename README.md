# FridgeIT Application 
[This repository contains a Flutter application developed using the Dart programming language. The application is designed to run on multiple platforms, including iOS, Android, and web.](https://github.com/coralavital/FridgeIT-Application.git)

## Installation
To run the Flutter application locally, please follow these steps:

1. Make sure you have Flutter and Dart installed on your machine. If not, refer to the [official Flutter documentation](https://flutter.dev/docs/get-started/install) for installation instructions.

2. Clone this repository to your local machine using the following command:
  git clone https://github.com/your-username/flutter-app.git

3. Navigate to the project directory:
  cd flutter-app

4. Install the necessary dependencies by running:
  flutter pub get
  
5. Run the Flutter application:
  flutter run
  This command will launch the application on the connected device or emulator.\


## Features
# Application README

This repository contains the source code for our application, which provides various features and functionalities for users. Here is an overview of the different screens and their functionalities:

## Login Screen
The login screen allows users to access the application by logging in with their credentials. It includes two fields - email and password. After entering the required login details, users can click on the "Login" button to access the main home page. If users haven't registered yet, they can click on the "Register" button. In case users have forgotten their password, they can click on the "I forgot my password" button.

## Signup Screen
The signup screen is designed for users who are new to the application. It contains several mandatory fields such as first name, last name, email, password, and gender. After providing the necessary registration information, users can click on the "Register" button to create an account and automatically navigate to the main home page. If users are already registered, they can click on the "Login" button. In case users forget their password, they can click on the "I forgot my password" button.

## Forget Password Screen
The forget password screen enables users to recover their account access even if they have forgotten their password. Users need to enter their registered email address in the mandatory email field and click on the "Reset password" button. Afterward, users will receive an email containing instructions to easily reset their password. Once the password is reset, users can log in to the application as usual.

## Main Home Screen
The main home screen displays a list of the latest products identified by the system. The list includes products detected based on the last two recorded images in the database. Users can view and interact with the displayed products on this screen.

## All Detected Products Screen
On the all detected products screen, users can view a comprehensive list of all products identified by the system since their initial connection. This list includes all products recognized by the model. Users also have the option to add any product from this list to their shopping list for better organization. To add a product to the shopping list, users can click on the "Add to shopping list" button displayed below the product name. Once a product is added to the shopping list, the "Add to cart" button next to the product will disappear.

## Shopping List Screen
The shopping list screen allows users to view and manage their selected items for purchase. Users can see the products previously identified by the system and added to their shopping list. The quantity of each item can be adjusted using the +/- buttons located under the product name. If the quantity of a product is set to 1 and the user clicks the "-" button, the product will be removed from the shopping list.

## Profile Screen
The profile screen provides users with information about the application and offers help resources. Users can log out of their account by clicking on the "Logout" button. Additionally, users have the option to delete their account by clicking on the "Delete account" button. If the user chooses to delete the account, a confirmation dialog will appear to confirm or cancel the deletion. Once the account is deleted, the user will be automatically redirected to the login page.

We hope you enjoy using our application! If you have any questions or need assistance, please refer to the documentation or reach out to our support team.

*This project is part of our software engineering bachelor's degree at SCE College.*



We appreciate your interest and hope you find this Flutter application useful!
