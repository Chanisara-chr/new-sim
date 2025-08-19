*** Settings ***
Library    SeleniumLibrary
Library    Collections
Library    OperatingSystem
Library    CSVLibrary


*** Variables ***
${URL}    sim-dev.toyota-asia.com
${BROWSER}    edge
${REMOTE_URL}
${CSV_FILE_PATH}    ${EXECDIR}/invoice_items.csv

*** Test Cases ***
Entry Invoice the first invoice, 10 items
    # Entry Website
    # Select menu Invoice Entry Screen
    # Select Item Type By Detail
    # Click Add Item
    # Verifies Item Name is    DI-IS Maintenance
    # Input item description    item-information-item-description-input-1    Outsource for PC Support and IT Operation Support +Network
    # Input Qty    item-information-qty-input-1    1
    # Input Price(THB)    item-information-price-thb-input-1    351895.24
    # Verifies Amount(THB) is    item-information-amount-thb-input-1    351895.24
    # Verifies Exchange Period is disable    item-information-exchange-period-dropdown-1
    # Verifies Average Ex. Rate is    item-information-average-ex-rate-input-1    1.000000
    # Verifies Price is    item-information-price-input-1    351895.24
    # Verifies Amount is    item-information-amount-input-1    351895.24
    Verify 9 Items from CSV File

*** Keywords ***
# Note: You must define the 'Add And Verify Invoice Item' keyword in your Resource file
Entry Website
    Open Browser    ${URL}    ${BROWSER}
    Wait Until Keyword Succeeds    5x    200ms    
    ...    Wait Until Page Contains    Selling Invoice Management 

Select menu Invoice Entry Screen
    Wait Until Element Is Visible    id=side-bar-transaction
    Click Element    id=side-bar-transaction
    Wait Until Element Is Visible    id=sub-side-bar-invoice-entry-screen    
    Click Element    id=sub-side-bar-invoice-entry-screen
    Wait Until Page Contains    Job

Select Item Type By Detail
    Select Radio Button    group_name=item-information-select-item-type    value=item-information-by-summary-radio

Add And Verify Invoice Items
    [Arguments]    ${item_name_locator}    ${item_name}    ${item_description_locator}    ${item_description}    ${item_qty_locator}    ${item_qty}   ${item_price_thb_locator}    ${item_price_thb}    ${item_amount_thb_locator}    ${item_amount_thb}    ${exchange_period_locator}    ${average_ex_rate_locator}    ${average_ex_rate}    ${item_price_locator}    ${item_price}    ${item_amount_locator}     ${item_amount}    
    Click Add Item
    Select Item Name    ${item_name_locator}    ${item_name}
    Input item description    ${item_description_locator}    ${item_description}
    Input Qty    ${item_qty_locator}    ${item_qty}
    Input Price(THB)    ${item_price_thb_locator}    ${item_price_thb}
    Verifies Amount(THB) is    ${item_amount_thb_locator}    ${item_amount_thb}
    Verifies Exchange Period is disable    ${exchange_period_locator}
    Verifies Average Ex. Rate is    ${average_ex_rate_locator}    ${average_ex_rate}
    Verifies Price is    ${item_price_locator}    ${item_price}
    Verifies Amount is    ${item_amount_locator}     ${item_amount}    

Click Add Item
    Click Button    id=item-information-add-btn

Select Item Name
    [Arguments]    ${item_name_locator}    ${item_name}
    Wait Until Keyword Succeeds    5x    200ms    
    ...    Select From List By Label    id=${item_name_locator}    ${item_name}

Verifies Item Name is
    [Arguments]    ${1st_item_name}
    Wait Until Keyword Succeeds    5x    200ms    Element Text Should Be    id=item-information-item-name-dropdown-1    value     ${1st_item_name}

Input item description
    [Arguments]    ${item_description_locator}    ${item_description}
    Input Text    id=${item_description_locator}   ${item_description}

Input Qty
    [Arguments]    ${item_qty_locator}    ${item_qty}
    Input Text    id=${item_qty_locator}    ${item_qty}

Input Price(THB)
    [Arguments]    ${item_price_thb_locator}    ${item_price_thb}
    Input Text    id=${item_price_thb_locator}    ${item_price_thb} 

Verifies Amount(THB) is
    [Arguments]    ${item_amount_thb_locator}    ${item_amount_thb}
    Wait Until Keyword Succeeds    5x    200ms    Element Text Should Be    id=${item_amount_thb_locator}    value    ${item_amount_thb}

Verifies Exchange Period is disable
    [Arguments]    ${exchange_period_locator}
    Element Should Be Disabled    id=${exchange_period_locator}

Verifies Average Ex. Rate is
    [Arguments]    ${average_ex_rate_locator}    ${average_ex_rate}
    Wait Until Element Contains    id=${average_ex_rate_locator}    ${average_ex_rate}

Verifies Price is
    [Arguments]    ${item_price_locator}    ${item_price}
    Wait Until Keyword Succeeds    5x    200ms    Element Text Should Be    id=${item_price_locator}    value    ${item_price}

Verifies Amount is
    [Arguments]    ${item_amount_locator}     ${item_amount}    
    Wait Until Keyword Succeeds    5x    200ms    Element Text Should Be    id=${item_amount_locator}    value    ${item_amount}

Verify 9 Items from CSV File
    [Arguments]    ${item_name_locator}    ${item_name}    ${item_description_locator}    ${item_description}    ${item_qty_locator}    ${item_qty}   ${item_price_thb_locator}    ${item_price_thb}    ${item_amount_thb_locator}    ${item_amount_thb}    ${exchange_period_locator}    ${average_ex_rate_locator}    ${average_ex_rate}    ${item_price_locator}    ${item_price}    ${item_amount_locator}     ${item_amount}    
    ${invoice_items} =    Read Csv File To List    ${CSV_FILE_PATH}
    
    FOR    ${item}    IN    @{invoice_items}
        # Add And Verify Invoice Items    ${item_name_locator}    ${item_name}    ${item_description_locator}    ${item_description}    ${item_qty_locator}    ${item_qty}   ${item_price_thb_locator}    ${item_price_thb}    ${item_amount_thb_locator}    ${item_amount_thb}    ${exchange_period_locator}    ${average_ex_rate_locator}    ${average_ex_rate}    ${item_price_locator}    ${item_price}    ${item_amount_locator}     ${item_amount}    
        Log To Console    ${item}
    END