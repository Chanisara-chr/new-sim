*** Settings ***
Library         SeleniumLibrary
Library         Collections
Library         OperatingSystem
Library         String

*** Variables ***
${URL}          sim-dev.toyota-asia.com
${BROWSER}      edge
${REMOTE_URL}
${CSV_FILE_PATH}    ${EXECDIR}/invoice_items.csv

*** Test Cases ***
Entry Invoice the first invoice, 10 items
    [Documentation]    Logs into the system and verifies the creation of an invoice with multiple items from a CSV file.
    
    # === Test Setup ===
    Entry Website
    Select menu Invoice Entry Screen
    Select Item Type By Detail
    
    # === Data-Driven Logic ===
    ${invoice_items} =    Read Csv File    ${CSV_FILE_PATH}
    
    FOR    ${item}    IN    @{invoice_items}
        Add And Verify Invoice Item    ${item}
    END
    
    # === Additional Verifications (e.g., check grand total) ===
    # You can add a keyword here to verify the final invoice total if needed.

*** Keywords ***
# The keyword definitions should remain as they are, but the FOR loop is removed from here.

# A keyword to read the CSV file
Read Csv File
    [Arguments]    ${file_path}
    ${data} =    Create List
    ${csv_content} =    OperatingSystem.Get File    ${file_path}
    @{lines} =    Split To Lines    ${csv_content}
    
    # Get headers from the first line
    ${header_line} =    Pop    @{lines}
    @{headers} =    Split String    ${header_line}    ,
    
    # Loop through remaining lines and create a list of dictionaries
    FOR    ${line}    IN    @{lines}
        @{values} =    Split String    ${line}    ,
        ${row_dict} =    Create Dictionary
        FOR    ${index}    IN RANGE    0    ${len(${headers})}
            Set To Dictionary    ${row_dict}    ${headers}[${index}]    ${values}[${index}]
        END
        Append To List    ${data}    ${row_dict}
    END
    RETURN    ${data}

# A reusable keyword to add and verify a single item
Add And Verify Invoice Item
    [Arguments]    ${item_data}
    
    Click Add Item
    
    # Using the locators and values from the dictionary
    Verifies Item Name is    ${item_data.ITEM_NAME}
    Input item description    ${item_data.ITEM_DESCRIPTION_LOCATOR}    ${item_data.ITEM_DESCRIPTION}
    Input Qty    ${item_data.ITEM_QTY_LOCATOR}    ${item_data.ITEM_QTY}
    Input Price(THB)    ${item_data.ITEM_PRICE_THB_LOCATOR}    ${item_data.ITEM_PRICE_THB}
    Verifies Amount(THB) is    ${item_data.ITEM_AMOUNT_THB_LOCATOR}    ${item_data.ITEM_AMOUNT_THB}
    Verifies Exchange Period is disable    ${item_data.EXCHANGE_PERIOD_LOCATOR}
    Verifies Average Ex. Rate is    ${item_data.AVERAGE_EX_RATE_LOCATOR}    ${item_data.AVERAGE_EX_RATE}
    Verifies Price is    ${item_data.ITEM_PRICE_LOCATOR}    ${item_data.ITEM_PRICE}
    Verifies Amount is    ${item_data.ITEM_AMOUNT_LOCATOR}    ${item_data.ITEM_AMOUNT}
    
# Add other keyword definitions here (Entry Website, Select menu, etc.)
Entry Website
    Open Browser    ${URL}    ${BROWSER}
    Wait Until Page Contains    Selling Invoice Management 

Select menu Invoice Entry Screen
    Wait Until Element Is Visible    id=side-bar-transaction
    Click Element    id=side-bar-transaction
    Wait Until Element Is Visible    id=sub-side-bar-invoice-entry-screen    
    Click Element    id=sub-side-bar-invoice-entry-screen
    Wait Until Page Contains    Job

Select Item Type By Detail
    Select Radio Button    group_name=item-information-select-item-type    value=item-information-by-summary-radio

Click Add Item
    Click Button    id=item-information-add-btn

Verifies Item Name is
    [Arguments]    ${1st_item_name}
    Wait Until Keyword Succeeds    5x    200ms    Element Text Should Be    id=item-information-item-name-dropdown-1    value    ${1st_item_name}

Input item description
    [Arguments]    ${item_description_locator}    ${item_description}
    Input Text    id=${item_description_locator}    ${item_description}

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