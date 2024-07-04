*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}    https://www.way2automation.com/angularjs-protractor/webtables/
${BROWSER}    edge
${WEB_TITLE}    Protractor practice website - WebTables
&{USER_HARRY}    first_name=Harry    last_name=Potter    user_name=harry    password=12345    customer=15    role=Sales Team    email=harry.potter@hogwarts.edu    cell_phone=+44 1234 567890
&{USER_NOVAK}    first_name=Mark    last_name=Novak    user_name=novak    password=67890    customer=16    role=Customer    email=novak@example.com    cell_phone=+886 0987 654321
&{USER_JOHN}    first_name=Jane    last_name=Smith    user_name=jane    password=12345    customer=15    role=Admin    email=john@example.com    cell_phone=+1 9999 00000

*** Test Cases ***
Open Browser and Verify Title
    [Documentation]    Open Browser and verify title
    [Setup]    Open Browser To URL
    Title Should Be    ${WEB_TITLE}
    [Teardown]    Close Browser

Add And Validate User
    [Documentation]    Add a new user and validate the user has been added
    [Setup]    Open Browser To URL
    Add User
    Input User Data    &{USER_HARRY}
    Verify Input Data    ${USER_HARRY['first_name']}
    Verify Input Data    ${USER_HARRY['last_name']}
    Verify Input Data    ${USER_HARRY['user_name']}
    Verify Input Data    ${USER_HARRY['email']}
    Verify Input Data    ${USER_HARRY['cell_phone']}
    [Teardown]    Close Browser

Delete And Validate User
    [Documentation]    Delete user name novak and validate the user has been deleted
    [Setup]    Open Browser To URL
    Verify Input Data    ${USER_NOVAK['user_name']}
    Delete User Name    ${USER_NOVAK['user_name']}
    [Teardown]    Close Browser
    Sleep    5

*** Keywords ***
Open Browser To URL
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window

Add User
    Wait Until Element Is Visible    xpath://button[@class='btn btn-link pull-right']
    Click Element    xpath://button[@class='btn btn-link pull-right']

Input User Data
    [Documentation]    Input User Data
    [Arguments]    &{INPUT_DATA}
    Input Text    xpath=//input[@name='FirstName']    ${INPUT_DATA['first_name']}
    Input Text    xpath=//input[@name='LastName']    ${INPUT_DATA['last_name']}
    Input Text    xpath=//input[@name='UserName']    ${INPUT_DATA['user_name']}
    Input Text    xpath=//input[@name='Password']    ${INPUT_DATA['password']}
    Select Radio Button    optionsRadios    ${INPUT_DATA['customer']}
    Select From List By Label    xpath=//select[@name='RoleId']    ${INPUT_DATA['role']}
    Input Text    xpath=//input[@name='Email']    ${INPUT_DATA['email']}
    Input Text    xpath=//input[@name='Mobilephone']    ${INPUT_DATA['cell_phone']}
    Sleep    5
    Click Element    xpath=//button[text()='Save']

Verify Input Data
    [Arguments]    ${INPUT_DATA_TO_VERIFY}
    Wait Until Element Is Visible    xpath://button[@class='btn btn-link pull-right']
    ${input_data_exists}    Run Keyword And Return Status    Element Should Be Visible    xpath=//td[text()='${INPUT_DATA_TO_VERIFY}']
    Log    input_data_exists = ${input_data_exists}
    Run Keyword If    '${input_data_exists}' == 'False'    Fail    Input Data '${INPUT_DATA_TO_VERIFY}' does not exist
    Sleep    5

Delete User Name
    [Arguments]    ${USER_NAME_TO_DELETE}
    Click Element    xpath=//td[text()='${USER_NAME_TO_DELETE}']/following-sibling::td/button[@ng-click='delUser()']
    Wait Until Element Is Visible    xpath=//h3[@class='ng-binding' and text()='Confirmation Dialog']
    Sleep    5
    Click Element    xpath=//button[text()='OK']
    ${user_deleted}    Run Keyword And Return Status    Element Should Not Be Visible    xpath=//td[text()='${USER_NAME_TO_DELETE}']
    Run Keyword If    '${user_deleted}' == 'False'    Fail    User '${USER_NAME_TO_DELETE}' was not deleted successfully
