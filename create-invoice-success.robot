*** Settings ***
Library    Collections
Library    CSVLibrary
Library    OperatingSystem
Library    SeleniumLibrary
Library    String

*** Variables ***
${URL}    sim-dev.toyota-asia.com
${BROWSER}    edge
${REMOTE_URL}
    
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
    Click Add Item
    Verifies Item Name is    DI-IS Maintenance
    Input item description    item-information-item-description-input-1    Outsource for PC Support and IT Operation Support +Network
    Input Qty    item-information-qty-input-1    1
    Input Price(THB)    item-information-price-thb-input-1    351895.24
    Verifies Amount(THB) is    item-information-amount-thb-input-1    351895.24
    Verifies Exchange Period is disable
    Verifies Average Ex. Rate is    1.000000
    Verifies Price is    item-information-price-input-1    351895.24
    Verifies Amount is    item-information-amount-input-1    351895.24
    # Verifies Base Amount is
# # Section Withholding Tax Information
#     Select Show detail on document is Yes
#     Verifies WHT Rate is enable
#     Input WHT Rate is 3
#     Verifies Total Amount is
#     Verifies Value Added Tax is 7 and Invoice is
#     Verifies Grand Total Amount is
#     Verifies Withholding Tax is 3 and Invoice is
#     Verifies Net Amount is
# # Save
#     Click Save

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
    Wait Until Keyword Succeeds    5x    200ms    Element Text Should Be    id=company-information-branch-dropdown    value     ${branch_name}

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
    Wait Until Keyword Succeeds    5x    200ms    Element Text Should Be    id=customer-information-customer-name-branch-dropdown    value     ${branch_name}
    
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
    Select Radio Button    group_name=item-information-select-item-type    value=item-information-by-summary-radio

Add And Verify Invoice Items
    Click Add Item

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
    Element Should Be Disabled    id=item-information-exchange-period-dropdown-1

Verifies Average Ex. Rate is
    [Arguments]    ${average_ex_rate}
    Wait Until Element Contains    id=item-information-average-ex-rate-input-1    ${average_ex_rate}

Verifies Price is
    [Arguments]    ${item_price_locator}    ${item_price}
    Wait Until Keyword Succeeds    5x    200ms    Element Text Should Be    id=${item_price_locator}    value    ${item_price}

Verifies Amount is
    [Arguments]    ${item_amount_locator}     ${item_amount}    
    Wait Until Keyword Succeeds    5x    200ms    Element Text Should Be    id=${item_amount_locator}    value    ${item_amount}

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
# Click Save
