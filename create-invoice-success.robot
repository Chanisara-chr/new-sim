*** Settings ***
Library    Collections
Library    CSVLibrary
Library    OperatingSystem
Library    SeleniumLibrary
Library    String
Library    DateTime

*** Variables ***
${URL}    sim-dev.toyota-asia.com
${BROWSER}    edge
${REMOTE_URL}   http://selenium-webdriver-edge:4444/wd/hub
${CSV_FILE_PATH}    ${EXECDIR}/invoice_items.csv
${GLOBAL_EXPECTED_DATE}
    
...    
*** Test Cases ***
Entry Invoice the first invoice, 10 items
    Entry Website
    Select menu Invoice Entry Screen
# Section Company Information
    Verifies Company Name is    TOYOTA MOTOR ASIA (THAILAND) CO., LTD.
    Verifies Company's Tax ID is    115546006888
    Verifies T/D is    Toyota
    Verifies User Name is    MISS Natnicha Rerngrit
    Verify Department is    Asia DX & IT Management
    Verifies total company's branches count is    1
    Search Company's Branch    Head office
    Verifies Company's branch is    00000 - Head office
    Verifies Company's address is    99 Moo 5, Ban Rakat, Bang Bo, Samut Prakan 10560 Thailand
# # Section Customer's Information
    Verifies total Customer Name count is    1
    Select Customer Name    TOYOTA AUTO WORKS CO.,LTD.
    Verifies total customer's branches count is    1
    Search Customer's Branch    Head Office
    Verifies Customer's branch is    Head Office
    Verifies Customer's Tax ID is    0115531001656
    Verifies Customer's address is    187 M.9 OLD RAILWAY RD., T.THEPHARAK, A.MUEANG, SAMUTPRAKAN Thailand 10270
    Veriies Remittance Due Date is    20th/Next MTH
    # Select Attn
    # Verifies Attn name is
    # Verifies Attn's e-mail is
    # Verifies Attn's Department is
    # Verifies CC name is
    # Verifies CC's e-mail is
    # Verifies CC's Department is
# # Section Document Type
#     Verifies total Business Category count is
#     Select Business Category
#     Verifies total Transaction Type count is
#     Select Transaction Type
#     Verifies WBS is enable
#     Verifies total Vat Scheme count is
#     Select Vat Scheme
#     Verifies Document Type is
#     Verifies Vat Rate is
# # Section Document Information
#     Input Ref. No.
#     Input Subject
#     Select WBS
#     Verifies Bank Information is
#     Verifies total Currency count is
#     Select Currency is
# # Section Item Information
    Select Item Type By Detail
    Verifies Item Name is    DI-IS Maintenance
    Input item description    item-information-item-description-input-0    Outsource for PC Support and IT Operation Support +Network
    Input Qty    item-information-qty-input-0    1
    Input Price(THB)    item-information-price-thb-input-0    351895.24
    Verifies Amount(THB) is    item-information-amount-thb-input-0    351895.24
    Verifies Exchange Period is disable    item-information-exchange-period-dropdown-0
    Verifies Average Ex. Rate is    item-information-average-ex-rate-input-0    1.000000
    Verifies Price is    item-information-price-input-0    351895.24
    Verifies Amount is    item-information-amount-input-0    351895.24
    Click Add Item
    Verify 9 Items
    # Verifies Base Amount is
# # Section Withholding Tax Information
    # Select Show detail on document is Yes
    # Verifies WHT Rate is enable
    # Input WHT Rate is 3
    # Verifies Total Amount is
    # Verifies Value Added Tax is 7 and Invoice is
    # Verifies Grand Total Amount is
    # Verifies Withholding Tax is 3 and Invoice is
    # Verifies Net Amount is
# # Save
#     Click Save
# # Work List Screen
    Entry Website
    Select menu Work List Screen
    Verifies PIC is    MISS Natnicha Rerngrit
    Verifies Create By is    MISS Natnicha Rerngrit
    Verifies table Job No. is    M-ITM2600001
    Verifies table REV is    00
    Verifies table Create By is    MISS Natnicha Rerngrit
    Verifies table Create Date is Current Date
    Verifies table Transaction Type is     DI-IS Maintenance
    Verifies table Invoice Amount is    5,234,868.20
    Verifies table Document Status is    Waiting for Submit


*** Keywords ***

Entry Website
    Open Browser    ${URL}    ${BROWSER}
    Wait Until Keyword Succeeds    5x    200ms    
    ...    Wait Until Page Contains    Selling Invoice Management 

Select menu Invoice Entry Screen
    Wait Until Element Is Visible    id=side-bar-transaction
    Click Element    id=side-bar-transaction
    Wait Until Element Is Visible    id=sub-side-bar-invoice-entry-screen    
    Click Element    id=sub-side-bar-invoice-entry-screen
    Wait Until Page Contains    Job No.

# Section Company Information

Verifies Company Name is
    [Arguments]    ${company_name}
    Wait Until Keyword Succeeds    5x    200ms    
    ...    Element Attribute Value Should Be    id=company-information-company-name-input    value    expected=${company_name}

Verifies Company's Tax ID is
    [Arguments]    ${company_tax_id}
    Wait Until Keyword Succeeds    5x    200ms    
    ...    Element Attribute Value Should Be    id=company-information-tax-id-input    value    expected=${company_tax_id}

Verifies T/D is
    [Arguments]    ${company_td}
    Radio Button Should Be Set To    company-information-td-option    value=${company_td}

Verifies User Name is
    [Arguments]    ${user_name}
    Wait Until Keyword Succeeds    5x    200ms    
    ...    Element Attribute Value Should Be    id=company-information-user-name-input    value    expected=${user_name}

Verify Department is
    [Arguments]    ${user_department}
    Wait Until Keyword Succeeds    5x    200ms    
    ...    Element Attribute Value Should Be    id=company-information-department-input    value    expected=${user_department}

Verifies total company's branches count is
    [Arguments]    ${company_branchs_length}
    ${branch_length}    Get Selected List Labels    id=company-information-branch-dropdown
    Length Should Be    ${branch_length}    length=${company_branchs_length}

Search Company's Branch
    [Arguments]    ${branch_name}
    Input Text    id=company-information-branch-dropdown    ${branch_name}
    Press Keys    None    ARROW_DOWN
    Press Keys    None    RETURN

Verifies Company's branch is
    [Arguments]    ${branch_name}
    Wait Until Keyword Succeeds    5x    200ms    Element Attribute Value Should Be    id=company-information-branch-dropdown    value     ${branch_name}

Verifies Company's address is
    [Arguments]    ${branch_address}
    Wait Until Keyword Succeeds    5x    200ms    
    ...    Element Attribute Value Should Be    id=company-information-address-id    value    ${branch_address}

# Section Customer's Information
Verifies total Customer Name count is
    [Arguments]    ${customer_name_list_length}
    ${customer_name_length}    Get Selected List Labels    id=company-information-branch-dropdown
    Length Should Be    ${customer_name_length}    length=${customer_name_list_length}

Select Customer Name
    [Arguments]    ${branch_name}
    Wait Until Keyword Succeeds    5x    200ms    Select From List By Label    id=customer-information-customer-name-dropdown     ${branch_name}

Verifies total customer's branches count is
    [Arguments]    ${customer_branches_list_length}
    ${customer_branches_length}    Get Selected List Labels    id=customer-information-customer-name-branch-dropdown
    Length Should Be    ${customer_branches_length}    length=${customer_branches_list_length}    

Search Customer's Branch
    [Arguments]    ${customer_branch}
    Input Text    id=customer-information-customer-name-branch-dropdown    ${customer_branch}
    Press Keys    None    ARROW_DOWN
    Press Keys    None    RETURN

Verifies Customer's branch is
    [Arguments]    ${branch_name}
    Wait Until Keyword Succeeds    5x    200ms    Element Attribute Value Should Be    id=customer-information-customer-name-branch-dropdown    value     ${branch_name}
    
Verifies Customer's Tax ID is
    [Arguments]    ${customer_tax_id}
    Wait Until Keyword Succeeds    5x    200ms    
    ...    Element Attribute Value Should Be    id=customer-information-tax-id-input    value    expected=${customer_tax_id}

Verifies Customer's address is
    [Arguments]    ${branch_address}
    Wait Until Keyword Succeeds    5x    200ms    
    ...    Element Attribute Value Should Be    id=customer-information-address-input    value    ${branch_address}

Veriies Remittance Due Date is
    [Arguments]    ${remittance_due_date}
    Wait Until Keyword Succeeds    5x    200ms    
    ...    Element Attribute Value Should Be    id=document-information-remittance-due-date-input    value    ${remittance_due_date}
    
# Select Attn
# Verifies Attn name is
# Verifies Attn's e-mail is
# Verifies Attn's Department is
# Verifies CC name is
# Verifies CC's e-mail is
# Verifies CC's Department is

# # Section Document Type
# Verifies total Business Category count is
# Select Business Category
# Verifies total Transaction Type count is
# Select Transaction Type
# Verifies WBS is enable
# Verifies total Vat Scheme count is
# Select Vat Scheme
# Verifies Document Type is
# Verifies Vat Rate is

# # Section Document Information
# Input Ref. No.
# Input Subject
# Select WBS
# Verifies Bank Information is
# Verifies total Currency count is
# Select Currency is

# # Section Item Information
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
    Wait Until Keyword Succeeds    5x    200ms    Element Attribute Value Should Be    id=item-information-item-name-dropdown-0    value     ${1st_item_name}

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
    Wait Until Keyword Succeeds    5x    200ms    Element Attribute Value Should Be    id=${item_amount_thb_locator}    value    ${item_amount_thb}

Verifies Exchange Period is disable
    [Arguments]    ${exchange_period_locator}
    Element Should Be Disabled    id=${exchange_period_locator}

Verifies Average Ex. Rate is
    [Arguments]    ${average_ex_rate_locator}    ${average_ex_rate}
    Wait Until Element Contains    id=${average_ex_rate_locator}    ${average_ex_rate}

Verifies Price is
    [Arguments]    ${item_price_locator}    ${item_price}
    Wait Until Keyword Succeeds    5x    200ms    Element Attribute Value Should Be    id=${item_price_locator}    value    ${item_price}

Verifies Amount is
    [Arguments]    ${item_amount_locator}     ${item_amount}    
    Wait Until Keyword Succeeds    5x    200ms    Element Attribute Value Should Be    id=${item_amount_locator}    value    ${item_amount}

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

# Verifies Base Amount is

# Section Withholding Tax Information
# Select Show detail on document is Yes
# Verifies WHT Rate is enable
# Input WHT Rate is 3
# Verifies Total Amount is
# Verifies Value Added Tax is 7 and Invoice is
# Verifies Grand Total Amount is
# Verifies Withholding Tax is 3 and Invoice is
# Verifies Net Amount is
# Save
# Click Save
# Work List Screen
Select menu Work List Screen
    Wait Until Element Is Visible    id=side-bar-transaction
    Click Element    id=side-bar-transaction
    Wait Until Element Is Visible    id=sub-side-bar-work-list-screen-btn    
    Click Element    id=sub-side-bar-work-list-screen-btn
    Wait Until Page Contains    PIC

Verifies PIC is
    [Arguments]    ${pic_name}
    Wait Until Keyword Succeeds    5x    200ms    
    ...    Element Attribute Value Should Be    id=pic-dropdown    value     ${pic_name}

Verifies Create By is
    [Arguments]    ${create_by_name}
    Wait Until Keyword Succeeds    5x    200ms    
    ...    Element Attribute Value Should Be    id=create-by-dropdown    value     ${create_by_name}
    

Verifies table Job No. is
    [Arguments]    ${job_no}
    Wait Until Keyword Succeeds    5x    200ms    Element Text Should Be    id=job-no-label-1    ${job_no}

Verifies table REV is
    [Arguments]    ${rev_no}
    Wait Until Keyword Succeeds    5x    200ms    Element Text Should Be    id=rev-label-1   ${rev_no}

Verifies table Create By is
    [Arguments]    ${create_by_name}
    Wait Until Keyword Succeeds    5x    200ms    Element Text Should Be    id=create-by-label-1   ${create_by_name}
  
Verifies table Create Date is Current Date
    Store Expected Date Globally
    Use Stored Global Date

Store Expected Date Globally
    ${expected_date}=    Get Current Date    result_format=%d-%b-%Y
    Set Global Variable    ${GLOBAL_EXPECTED_DATE}    ${expected_date}

Use Stored Global Date
    ${actual_creation_date}=    Get Text    create-date-label-1
    Should Be Equal    ${actual_creation_date}    ${GLOBAL_EXPECTED_DATE}
    
Verifies table Transaction Type is
    [Arguments]    ${transaction_type}
    Wait Until Keyword Succeeds    5x    200ms    Element Text Should Be    id=transaction-type-label-1   ${transaction_type}

Verifies table Invoice Amount is  
    [Arguments]    ${invoice_amount}
    Wait Until Keyword Succeeds    5x    200ms    Element Text Should Be    id=invoice-amount-label-1   ${invoice_amount}

Verifies table Document Status is
    [Arguments]    ${doc_status}
    Wait Until Keyword Succeeds    5x    200ms    Element Text Should Be    id=document-status-label-1   ${doc_status}



