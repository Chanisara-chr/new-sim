*** Settings ***
Library    Collections
Library    CSVLibrary
Library    OperatingSystem
Library    SeleniumLibrary
Library    String

*** Variables ***
${URL}    http://ge0-web:3000
${BROWSER}    edge
${REMOTE_URL}   http://selenium-webdriver-edge:4444/wd/hub
${CSV_FILE_PATH}    ${EXECDIR}/invoice_items.csv

*** Test Cases ***
Entry Invoice the first invoice, 10 items
    Entry Website
    Select menu Invoice Entry Screen
# Section Company Information
    # Verifies Company Name is    TOYOTA MOTOR ASIA (THAILAND) CO., LTD.
    # Verifies Company's Tax ID is    115546006888
    # Verifies T/D is    Toyota
    # Verifies User Name is    MISS Natnicha Rerngrit
    # Verify Department is    Asia DX & IT Management
    # Verifies total company's branches count is    1
    # Search Company's Branch    Head office
    # Verifies Company's branch is    00000 - Head office
    # Verifies Company's address is    99 Moo 5, Ban Rakat, Bang Bo, Samut Prakan 10560 Thailand
# Section Customer's Information
    # Verifies total Customer Name count is    1
    # Select Customer Name    TOYOTA AUTO WORKS CO.,LTD.
    # Verifies total customer's branches count is    1
    # Search Customer's Branch    Head Office
    # Verifies Customer's branch is    Head Office
    # Verifies Customer's Tax ID is    0115531001656
    # Verifies Customer's address is    187 M.9 OLD RAILWAY RD., T.THEPHARAK, A.MUEANG, SAMUTPRAKAN Thailand 10270
    # Veriies Remittance Due Date is    20th/Next MTH
# Section Item Information
    Select Item Type By Detail
    Click Add Item
    Verifies Item Name is    DI-IS Maintenance
    Input item description    item-information-item-description-input-1    Outsource for PC Support and IT Operation Support +Network
    Input Qty    item-information-qty-input-1    1
    Input Price(THB)    item-information-price-thb-input-1    351895.24
    Verifies Amount(THB) is    item-information-amount-thb-input-1    351895.24
    Verifies Exchange Period is disable    item-information-exchange-period-dropdown-1
    Verifies Average Ex. Rate is    item-information-average-ex-rate-input-1    1.000000
    Verifies Price is    item-information-price-input-1    351895.24
    Verifies Amount is    item-information-amount-input-1    351895.24
    Verify 9 Items

*** Keywords ***
Entry Website
#    Open Browser    ${URL}    ${BROWSER}    ${REMOTE_URL}
    Open Browser    ${URL}    ${BROWSER}    remote_url=${REMOTE_URL}
    Wait Until Keyword Succeeds    5x    200ms    
    ...    Wait Until Page Contains    Selling Invoice Management

Select menu Invoice Entry Screen
    Wait Until Element Is Visible    id=side-bar-transaction-btn
    Click Element    id=side-bar-transaction-btn
    Wait Until Element Is Visible    id=sub-side-bar-invoice-entry-screen-btn   
    Click Element    id=sub-side-bar-invoice-entry-screen-btn
    Wait Until Page Contains    Information

# Section Company Information

# Verifies Company Name is
#     [Arguments]    ${company_name}
#     Wait Until Keyword Succeeds    5x    200ms    
#     ...    Element Attribute Value Should Be    id=company-information-company-name-input    value    expected=${company_name}

# Verifies Company's Tax ID is
#     [Arguments]    ${company_tax_id}
#     Wait Until Keyword Succeeds    5x    200ms    
#     ...    Element Attribute Value Should Be    id=company-information-tax-id-input    value    expected=${company_tax_id}

# Verifies T/D is
#     [Arguments]    ${company_td}
#     Radio Button Should Be Set To    company-information-td-option    value=${company_td}

# Verifies User Name is
#     [Arguments]    ${user_name}
#     Wait Until Keyword Succeeds    5x    200ms    
#     ...    Element Attribute Value Should Be    id=company-information-user-name-input    value    expected=${user_name}

# Verify Department is
#     [Arguments]    ${user_department}
#     Wait Until Keyword Succeeds    5x    200ms    
#     ...    Element Attribute Value Should Be    id=company-information-department-input    value    expected=${user_department}

# Verifies total company's branches count is
#     [Arguments]    ${company_branchs_length}
#     ${branch_length}    Get Selected List Labels    id=company-information-branch-dropdown
#     Length Should Be    ${branch_length}    length=${company_branchs_length}

# Search Company's Branch
#     [Arguments]    ${branch_name}
#     Input Text    id=company-information-branch-dropdown    ${branch_name}
#     Press Keys    None    ARROW_DOWN
#     Press Keys    None    RETURN

# Verifies Company's branch is
#     [Arguments]    ${branch_name}
#     Wait Until Keyword Succeeds    5x    200ms    Element Text Should Be    id=company-information-branch-dropdown    value     ${branch_name}

# Verifies Company's address is
#     [Arguments]    ${branch_address}
#     Wait Until Keyword Succeeds    5x    200ms    
#     ...    Element Attribute Value Should Be    id=company-information-address-id    value    ${branch_address}

# # Section Customer's Information
# Verifies total Customer Name count is
#     [Arguments]    ${customer_name_list_length}
#     ${customer_name_length}    Get Selected List Labels    id=company-information-branch-dropdown
#     Length Should Be    ${customer_name_length}    length=${customer_name_list_length}

# Select Customer Name
#     [Arguments]    ${branch_name}
#     Wait Until Keyword Succeeds    5x    200ms    Select From List By Label    id=customer-information-customer-name-dropdown     ${branch_name}

# Verifies total customer's branches count is
#     [Arguments]    ${customer_branches_list_length}
#     ${customer_branches_length}    Get Selected List Labels    id=customer-information-customer-name-branch-dropdown
#     Length Should Be    ${customer_branches_length}    length=${customer_branches_list_length}    

# Search Customer's Branch
#     [Arguments]    ${customer_branch}
#     Input Text    id=customer-information-customer-name-branch-dropdown    ${customer_branch}
#     Press Keys    None    ARROW_DOWN
#     Press Keys    None    RETURN

# Verifies Customer's branch is
#     [Arguments]    ${branch_name}
#     Wait Until Keyword Succeeds    5x    200ms    Element Text Should Be    id=customer-information-customer-name-branch-dropdown    value     ${branch_name}
    
# Verifies Customer's Tax ID is
#     [Arguments]    ${customer_tax_id}
#     Wait Until Keyword Succeeds    5x    200ms    
#     ...    Element Attribute Value Should Be    id=customer-information-tax-id-input    value    expected=${customer_tax_id}

# Verifies Customer's address is
#     [Arguments]    ${branch_address}
#     Wait Until Keyword Succeeds    5x    200ms    
#     ...    Element Attribute Value Should Be    id=customer-information-address-input    value    ${branch_address}

# Veriies Remittance Due Date is
#     [Arguments]    ${remittance_due_date}
#     Wait Until Keyword Succeeds    5x    200ms    
#     ...    Element Attribute Value Should Be    id=document-information-remittance-due-date-input    value    ${remittance_due_date}

# Section Item Information
Select Item Type By Detail
    Wait Until Keyword Succeeds    5x    200ms    Select Radio Button    group_name=item-information-select-item-type    value=item-information-by-summary-radio

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

Verify 9 Items
    @{csv_data}=    Read CSV File To List Of Dictionaries    ${CSV_FILE_PATH}
    
    FOR    ${item_data}    IN    @{csv_data}
        Add And Verify Invoice Items    ${item_data}
    END

Add And Verify Invoice Items
    [Arguments]    ${item_data}
    Click Add Item
    Select Item Name    ${item_data}[item_name_locator]    ${item_data}[item_name]
    Input item description    ${item_data}[item_description_locator]    ${item_data}[item_description]
    Input Qty    ${item_data}[item_qty_locator]    ${item_data}[item_qty]
    Input Price(THB)    ${item_data}[item_price_thb_locator]    ${item_data}[item_price_thb]
    Verifies Amount(THB) is    ${item_data}[item_amount_thb_locator]    ${item_data}[item_amount_thb]
    Verifies Exchange Period is disable    ${item_data}[exchange_period_locator]
    Verifies Average Ex. Rate is    ${item_data}[average_ex_rate_locator]    ${item_data}[average_ex_rate]
    Verifies Price is    ${item_data}[item_price_locator]    ${item_data}[item_price]
    Verifies Amount is    ${item_data}[item_amount_locator]     ${item_data}[item_amount]    

Read CSV File To List Of Dictionaries
    [Arguments]    ${file_path}
    [Documentation]    Read CSV file and return as list of dictionaries
    
    ${csv_content}=    Get File    ${file_path}
    @{lines}=    Split To Lines    ${csv_content}
    ${header_line}=    Get From List    ${lines}    0
    @{headers}=    Split String    ${header_line}    ,
    
    @{data_list}=    Create List
    
    FOR    ${i}    IN RANGE    1    ${lines.__len__()}
        ${line}=    Get From List    ${lines}    ${i}
        @{values}=    Split String    ${line}    ,
        &{row_dict}=    Create Dictionary
        
        FOR    ${j}    IN RANGE    ${headers.__len__()}
            ${header}=    Get From List    ${headers}    ${j}
            ${value}=    Get From List    ${values}    ${j}
            Set To Dictionary    ${row_dict}    ${header}    ${value}
        END
        
        Append To List    ${data_list}    ${row_dict}
    END
    
    RETURN    @{data_list}
