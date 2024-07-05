# Automate_Test
Instructions:

1.Fork this repo.

2.Use Python with Robot or Cucumber.

3.Create a branch and name it with your "{firstname_lastname}_challenge" Make sure to update your README to show how to run your scripts Fulfill the following two scenarios Once complete push your branch up

Feature: Automate As an Engr. 

Candidate I need to automate http://www.way2automation.com/angularjs-protractor/webtables/ So I can show my automation capabilities

Scenario: Add a user and validate the user has been added to the table

Scenario: Delete user User Name: novak and validate user has been deleted


# Jaron Cheng Challenge

This repository contains Robot Framework test cases for automating user management functionalities on the [Way2Automation Protractor practice website](https://www.way2automation.com/angularjs-protractor/webtables/).

## 1. Prerequisites

- Python 3.x installed
- Robot Framework installed
- SeleniumLibrary installed
- Browser driver (e.g., EdgeDriver, ChromeDriver) installed and added to PATH
- Edge browser installed (or modify the script to use a different browser)
- Find variable "browser" in the code and change it to meet your environment  

`
*** Variables ***
&{EDGE_AUTOMATION}    browser=edge    url=https://www.way2automation.com/angularjs-protractor/webtables/    title=Protractor practice website - WebTables
`

### Installing Robot Framework and SeleniumLibrary

```bash
pip install robotframework
pip install robotframework-seleniumlibrary
```

## 2. Run Test Script

* Run Scenario: Add a user and validate the user has been added to the table

```cmd
robot --test "Add And Validate User" .\manage_user.robot
```

* Run Scenario: Delete user User Name: novak and validate user has been deleted

```cmd
robot --test "Delete And Validate User" .\manage_user.robot
```

* Run both scenarios

```cmd
robot .\manage_user.robot
```

## 3. Test Details

### 3.1 Add and Validate User
The add_and_validate_user.robot test case includes the following steps:
- Open the browser and navigate to the URL.
- Add a new user with predefined details.
- Verify that the user has been added successfully.
- Close the browser.

### 3.2 Delete and Validate User
The delete_and_validate_user.robot test case includes the following steps:
- Open the browser and navigate to the URL.
- Verify that the user exists.
- Delete the user.
- Verify that the user has been deleted successfully.
- Close the browser.

