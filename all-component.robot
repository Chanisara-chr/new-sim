*** Settings ***
Library    Collections
Library    CSVLibrary
Library    OperatingSystem
Library    SeleniumLibrary
Library    String
Library    DateTime

*** Variables ***


*** Test Cases ***
Section Dropdown
    Select Main Dropdown


*** Keywords ***
Select Main Dropdown
    [Arguments]    ${customer_name_list_length}
    ${customer_name_length}    Get List Items    id=company-information-branch-dropdown
    Length Should Be    ${customer_name_length}    length=${customer_name_list_length}
