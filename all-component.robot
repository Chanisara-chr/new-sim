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
    Select From List By Label    id=main-dropdown-normal    option-0