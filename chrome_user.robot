*** Settings ***
Library    SeleniumLibrary

*** Variables ***
&{CHROME_AUTOMATION}    browser=chrome    url=https://www.way2automation.com/angularjs-protractor/webtables/    title=Protractor practice website - WebTables
&{USER_HARRY}    first_name=Harry    last_name=Potter    user_name=harry    password=12345    customer=15    role=Sales Team    email=harry.potter@hogwarts.edu    cell_phone=+44 1234 567890    str_customer=Company AAA
&{USER_NOVAK}    first_name=Mark    last_name=Novak    user_name=novak    password=67890    customer=16    role=Customer    email=novak@example.com    cell_phone=+886 0987 654321    str_customer=Company BBB
#&{USER_JANE}    first_name=Jane    last_name=Smith    user_name=jane    password=12345    customer=15    role=Admin    email=john@example.com    cell_phone=+1 9999 00000    str_customer=Company AAA

*** Test Cases ***
Add And Validate User
    [Documentation]    Add user Harry and validate the data has been added in the first row
    [Setup]    Open Browser To URL    &{CHROME_AUTOMATION}
    Add User
    Input User Data    &{USER_HARRY}
    Verify New User    &{USER_HARRY}
    [Teardown]    Close Browser

Delete And Validate User
    [Documentation]    Remove novak and validate the data has been deleted
    [Setup]    Open Browser To URL    &{CHROME_AUTOMATION}
    Verify Text    ${USER_NOVAK['user_name']}
    Delete User Name    ${USER_NOVAK['user_name']}
    [Teardown]    Close Browser

*** Keywords ***
Open Browser To URL
    [Documentation]    Start out automated testing 
    [Arguments]    &{ARG1}
    Open Browser    ${ARG1['url']}    ${ARG1['browser']}
    Title Should Be    ${ARG1['title']}
    Maximize Browser Window

Add User
    [Documentation]    Click and pop up window 
    Wait Until Element Is Visible    xpath://button[@class='btn btn-link pull-right']
    Click Element    xpath://button[@class='btn btn-link pull-right']

Input User Data
    [Documentation]    Input user data
    [Arguments]    &{ARG2}
    Input Text    xpath=//input[@name='FirstName']    ${ARG2['first_name']}
    Input Text    xpath=//input[@name='LastName']    ${ARG2['last_name']}
    Input Text    xpath=//input[@name='UserName']    ${ARG2['user_name']}
    Input Text    xpath=//input[@name='Password']    ${ARG2['password']}
    Select Radio Button    optionsRadios    ${ARG2['customer']}
    Select From List By Label    xpath=//select[@name='RoleId']    ${ARG2['role']}
    Input Text    xpath=//input[@name='Email']    ${ARG2['email']}
    Input Text    xpath=//input[@name='Mobilephone']    ${ARG2['cell_phone']}
    Click Element    xpath=//button[text()='Save']

Verify Text
    [Documentation]    Check whether the text is as expected
    [Arguments]    ${ARG3}
    Wait Until Element Is Visible    xpath=//td[text()='${ARG3}']
    ${input_data_exists}    Run Keyword And Return Status    Element Should Be Visible    xpath=//td[text()='${ARG3}']
    Log    input_data_exists = ${input_data_exists}
    Run Keyword If    '${input_data_exists}' == 'False'    Fail    Input Data '${ARG3}' does not exist

Delete User Name
    [Documentation]    Click delete button and confirm whether user has been removed
    [Arguments]    ${ARG4}
    Click Element    xpath=//td[text()='${ARG4}']/following-sibling::td/button[@ng-click='delUser()']
    Wait Until Element Is Visible    xpath=//h3[@class='ng-binding' and text()='Confirmation Dialog']
    Click Element    xpath=//button[text()='OK']
    ${user_deleted}    Run Keyword And Return Status    Element Should Not Be Visible    xpath=//td[text()='${ARG4}']
    Run Keyword If    '${user_deleted}' == 'False'    Fail    User '${ARG4}' was not deleted successfully

Verify Newly Added
    [Documentation]    Check whether or not the text in the first row is as expected
    [Arguments]    ${ARG5}
    Wait Until Element Is Visible    xpath=//td[text()='${ARG5}']
    ${new_data_exists}    Run Keyword And Return Status    Element Should Be Visible    xpath=//table//tr[1]//td[text()='${ARG5}']
    Log    new_data_exists = ${new_data_exists}
    Run Keyword If    '${new_data_exists}' == 'False'    Fail    Input Data '${ARG5}' does not exist

Verify New User
    [Documentation]    Check whether or not the newly added data meets
    [Arguments]    &{ARG6}
    Verify Newly Added    ${ARG6['first_name']}
    Verify Newly Added    ${ARG6['last_name']}
    Verify Newly Added    ${ARG6['user_name']}
    Verify Newly Added    ${ARG6['email']}
    Verify Newly Added    ${ARG6['cell_phone']}
    #Verify Newly Added    ${ARG6['str_customer']}
    Verify Newly Added    ${ARG6['role']}
