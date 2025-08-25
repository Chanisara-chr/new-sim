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
${RETRY}    5x
${INTERVAL}    250ms
${ADD_9_ITEMS_FILE_PATH}    ${EXECDIR}/invoice_items.csv
${ADD_ITEMS_NO_9_FILE_PATH}    ${EXECDIR}/invoice_add_item_no_9.csv
${ADD_ITEMS_NO_10_FILE_PATH}    ${EXECDIR}/invoice_add_item_no_10.csv
${8_ITEMS_REMAINING_FILE_PATH}    ${EXECDIR}/invoice_item_remaining.csv
${10_ITEMS_FILE_PATH}    ${EXECDIR}/new_invoice_10_items.csv
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
    Verifies Customer Name is    TOYOTA AUTO WORKS CO.,LTD.
    Verifies total customer's branches count is    1
    Search Customer's Branch    Head Office
    Verifies Customer's branch is    Head Office
    Verifies Customer's Tax ID is    0115531001656
    Verifies Customer's address is    187 M.9 OLD RAILWAY RD., T.THEPHARAK, A.MUEANG, SAMUTPRAKAN Thailand 10270
    Veriies Remittance Due Date is    20th/Next MTH
    Select Attn    Paiboon Sripituckpong
    Verifies Attn name is    Paiboon Sripituckpong
    Verifies Attn's e-mail is    psripitu@taw.co.th
    Verifies Attn's Department is    Plant Administration
    Verifies CC name is    Sarawoot Intharadet
    Verifies CC's e-mail is    sinthara@taw.co.th
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
# # Section Item Information add 10 items
    Select Item Type By Detail
    Verifies Item Table is    No data available
    Add 1st item
    Add and Verifies Invoice Items    ${ADD_9_ITEMS_FILE_PATH}

# # Section Withholding Tax Information
    Select Show detail on document is Yes
    Verifies Base Amount and WHT Rate is enable
    Input WHT Rate is 3
    Verifies Withholding Tax is 3 and Invoice is    146,772.01
    Verifies Net Amount is    5,088,096.19

# # Section Item Information delete and add 2items
    Select Checkbox item    item-information-selected-item-checkbox-2
    Select Checkbox item    item-information-selected-item-checkbox-5
    Click Delete
    # Verifies Delete modal text is
    # Click confirm Delete
    # Verifies Toast Delete success message is
    # Verifies Toase Delete success is disappear in 5 sec
    Verifies Invoice 8 Items    ${8_ITEMS_REMAINING_FILE_PATH}
    Verifies Items order is 1 -    8
    Verifies Base Amount is    3,574,165.41
    Verifies Total Amount is    3,574,165.41
    Verifies Value Added Tax (Vat) is    250,191.58
    Verifies Grand Total Amount is    3,824,356.99
    Add and Verifies Invoice Items    ${ADD_ITEMS_NO_9_FILE_PATH}
    Verifies Withholding Tax is 3 and Invoice is    126,124.14
    Verifies Net Amount is    4,372,303.59
    Add and Verifies Invoice Items    ${ADD_ITEMS_NO_10_FILE_PATH}
    Verifies Withholding Tax is 3 and Invoice is    146,772.01
    Verifies Net Amount is    5,088,096.19

# # Save
    Click Save
# # Work List Screen
    Close Browser
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
    Click Job NO.    M-ITM2600001

# # Verify data on invoice entry page after dave
    Verifies Company Name is    TOYOTA MOTOR ASIA (THAILAND) CO., LTD.
    Verifies Company's Tax ID is    115546006888
    Verifies T/D is    Toyota
    Verifies User Name is    MISS Natnicha Rerngrit
    Verify Department is    Asia DX & IT Management
    Verifies total company's branches count is    1
    Verifies Company's branch is    00000 - Head office
    Verifies Company's address is    99 Moo 5, Ban Rakat, Bang Bo, Samut Prakan 10560 Thailand 
    Verifies total Customer Name count is    1
    Verifies Customer Name is    TOYOTA AUTO WORKS CO.,LTD.
    Verifies total customer's branches count is    1
    Verifies Customer's branch is    Head Office
    Verifies Customer's Tax ID is    0115531001656
    Verifies Customer's address is    187 M.9 OLD RAILWAY RD., T.THEPHARAK, A.MUEANG, SAMUTPRAKAN Thailand 10270
    Veriies Remittance Due Date is    20th/Next MTH
    Verifies Attn name is    Paiboon Sripituckpong
    Verifies Attn's e-mail is    psripitu@taw.co.th
    Verifies Attn's Department is    Plant Administration
    Verifies CC name is    Sarawoot Intharadet
    Verifies CC's e-mail is    sinthara@taw.co.th
    Verifies Invoice 10 Items    ${10_ITEMS_FILE_PATH}
    Verifies Items order is 1 -    10
    Verifies Base Amount is    4,892,400.19
    Verifies Total Amount is    4,892,400.19
    Verifies Value Added Tax (Vat) is    342,468.01
    Verifies Grand Total Amount is    5,234,868.20
    Verifies Withholding Tax is 3 and Invoice is    146,772.01
    Verifies Net Amount is    5,088,096.19



*** Keywords ***

Entry Website
    Open Browser    ${URL}    ${BROWSER}
    Wait Until Keyword Succeeds    5x    200ms    
    ...    Wait Until Page Contains    Selling Invoice Management 

Select menu Invoice Entry Screen
    Wait Until Element Is Visible    id=side-bar-transaction-btn
    Click Element    id=side-bar-transaction-btn
    Wait Until Element Is Visible    id=sub-side-bar-invoice-entry-screen-btn    
    Click Element    id=sub-side-bar-invoice-entry-screen-btn
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
    [Arguments]    ${customer_name}
    Wait Until Keyword Succeeds    5x    200ms    Select From List By Label    id=customer-information-customer-name-dropdown     ${customer_name}

Verifies Customer Name is
    [Arguments]    ${customer_name}
    Wait Until Keyword Succeeds    5x    200ms    Element Attribute Value Should Be    id=customer-information-customer-name-dropdown    value     ${customer_name}

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
    
Select Attn
    [Arguments]    ${attn_name}
    Wait Until Keyword Succeeds    5x    200ms    Select From List By Label    id=customer-information-attn-dropdown     ${attn_name}
    
Verifies Attn name is
    [Arguments]    ${attn_name}
    Wait Until Keyword Succeeds    5x    200ms    
    ...    Element Attribute Value Should Be    id=customer-information-attn-dropdown    value    ${attn_name}
    
Verifies Attn's e-mail is
    [Arguments]    ${attn_email}
    Wait Until Keyword Succeeds    5x    200ms    
    ...    Element Attribute Value Should Be    id=customer-information-attn-email-input    value    ${attn_email}

Verifies Attn's Department is
    [Arguments]    ${attn_department}
    Wait Until Keyword Succeeds    5x    200ms    
    ...    Element Attribute Value Should Be    id=customer-information-attn-department-input    value    ${attn_department}

Verifies CC name is
    [Arguments]    ${cc_name}
    Wait Until Keyword Succeeds    ${RETRY}    ${INTERVAL}    
    ...    Element Attribute Value Should Be    id=customer-information-cc-input    value    ${cc_name}

Verifies CC's e-mail is
    [Arguments]    ${cc_email}
    Wait Until Keyword Succeeds    ${RETRY}    ${INTERVAL}    
    ...    Element Attribute Value Should Be    id=customer-information-cc-email-input    value    ${cc_email}

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

Verifies Item Table is
    [Arguments]    ${no_data_content}
    Wait Until Keyword Succeeds    5x    200ms    Element Should Contain    item-information-table-no-data    ${no_data_content}

Verifies Item Name is
    [Arguments]    ${item_name_locator}    ${item_name}
    Wait Until Keyword Succeeds    5x    200ms    Element Text Should Be    id=${item_name_locator}    ${item_name}

Click Add Item
    Click Button    id=item-information-add-btn

Select Item Name
    [Arguments]    ${item_name_locator}    ${item_name}
    Wait Until Keyword Succeeds    5x    200ms    
    ...    Select From List By Label    id=${item_name_locator}    ${item_name}

Input item description
    [Arguments]    ${item_description_locator}    ${item_description}
    Input Text    id=${item_description_locator}   ${item_description}

Verifies item description is
    [Arguments]    ${item_desc_locator}    ${item_desc}
    Wait Until Keyword Succeeds    5x    200ms    Element Attribute Value Should Be    id=${item_desc_locator}    value     ${item_desc}

Input Qty
    [Arguments]    ${item_qty_locator}    ${item_qty}
    Input Text    id=${item_qty_locator}    ${item_qty}

Verifies item Qty
    [Arguments]    ${item_qty_locator}    ${item_qty}
    Wait Until Keyword Succeeds    5x    200ms    Element Attribute Value Should Be    id=${item_qty_locator}    value     ${item_qty}

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

Verifies Base Amount is
    [Arguments]    ${base_amount}    
    Wait Until Keyword Succeeds    5x    200ms    Element Attribute Value Should Be    id=withholding-tax-information-base-amount-input    value    ${base_amount}

Verifies Total Amount is
    [Arguments]    ${total_amount}    
    Wait Until Keyword Succeeds    5x    200ms    Element Attribute Value Should Be    id=document-summary-total-amount-invoice-input    value    ${total_amount}

Verifies Value Added Tax (Vat) is
    [Arguments]    ${vat}    
    Wait Until Keyword Succeeds    5x    200ms    Element Attribute Value Should Be    id=document-summary-vat-invoice-input    value    ${vat}

Verifies Grand Total Amount is
    [Arguments]    ${grand_total_amount}    
    Wait Until Keyword Succeeds    5x    200ms    Element Attribute Value Should Be    id=document-summary-grand-total-amount-invoice-input     value    ${grand_total_amount}

Add 1st item
    Click Add Item
    Verifies Item Name is    item-information-item-name-dropdown-0    DI-IS Maintenance
    Input item description    item-information-item-description-input-0    Outsource for PC Support and IT Operation Support +Network
    Input Qty    item-information-qty-input-0    1
    Input Price(THB)    item-information-price-thb-input-0    351895.24
    Verifies Amount(THB) is    item-information-amount-thb-input-0    351895.24
    Verifies Exchange Period is disable    item-information-exchange-period-dropdown-0
    Verifies Average Ex. Rate is    item-information-average-ex-rate-input-0    1.000000
    Verifies Price is    item-information-price-input-0    351895.24
    Verifies Amount is    item-information-amount-input-0    351895.24
    Verifies Base Amount is    351895.24    
    Verifies Total Amount is    351895.24
    Verifies Value Added Tax (Vat) is    24632.67        
    Verifies Grand Total Amount is    376527.91

Add and Verifies Invoice Items
    [Arguments]    ${file_path}
    @{csv_data}=    Read CSV File To List Of Dictionaries    ${file_path}
    
    FOR    ${item_data}    IN    @{csv_data}
        Add Invoice Items    ${item_data}
    END

Add Invoice Items
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
    Verifies Base Amount is    ${item_data}[base_amount]
    Verifies Total Amount is    ${item_data}[total_amount]
    Verifies Value Added Tax (Vat) is    ${item_data}[vat]
    Verifies Grand Total Amount is    ${item_data}[grand_total_amount]

Read CSV File To List Of Dictionaries
    [Arguments]    ${file_path}
    
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

# Section Withholding Tax Information
Select Show detail on document is Yes
    Click Element    id=withholding-tax-information-yes-radio

Verifies Base Amount and WHT Rate is enable
    Wait Until Keyword Succeeds    ${RETRY}    ${INTERVAL}    Element Should Be Enabled    id=withholding-tax-information-base-amount-input
    Wait Until Keyword Succeeds    ${RETRY}    ${INTERVAL}    Element Should Be Enabled    id=withholding-tax-information-wth-rate-input
    
Input WHT Rate is 3
    Input Text    id=withholding-tax-information-wth-rate-input    3

Verifies Withholding Tax is 3 and Invoice is
    [Arguments]    ${wth_tax_invoice}
    Element Text Should Be    id=document-summary-withholding-tax-label    3.00%    
    Wait Until Keyword Succeeds    5x    200ms    Element Attribute Value Should Be    id=document-summary-withholding-tax-invoice-input     value    ${wth_tax_invoice}
    
Verifies Net Amount is
    [Arguments]    ${net_amount}
    Wait Until Keyword Succeeds    5x    200ms    Element Attribute Value Should Be    id=document-summary-net-amount-invoice-input     value    ${net_amount}

# # Section Item Information delete and add 2items
Select Checkbox item
    [Arguments]    ${checkbox_locator}
    Select Checkbox    id=${checkbox_locator}

Click Delete
    Click Button    item-information-delete-btn

# Verifies Delete modal text is
# Click confirm Delete
# Verifies Toast Delete success message is
# Verifies Toase Delete success is disappear in 5 sec

Verifies Invoice 8 Items
    [Arguments]    ${file_path}
    @{csv_data}=    Read CSV File To List Of Dictionaries    ${file_path}
    
    FOR    ${item_data}    IN    @{csv_data}
        Verifies Item remaining    ${item_data}
    END

Verifies Item remaining 
    [Arguments]    ${item_data}
    Verifies Item Name is    ${item_data}[item_name_locator]    ${item_data}[item_name]    
    Verifies item description is    ${item_data}[item_desc_locator]    ${item_data}[item_desc]
    Verifies item Qty    ${item_data}[item_qty_locator]    ${item_data}[item_qty]
    Verifies Amount(THB) is    ${item_data}[item_amount_thb_locator]    ${item_data}[item_amount_thb]
    Verifies Exchange Period is disable    ${item_data}[exchange_period_locator]
    Verifies Average Ex. Rate is    ${item_data}[average_ex_rate_locator]    ${item_data}[average_ex_rate]
    Verifies Price is    ${item_data}[item_price_locator]    ${item_data}[item_price]
    Verifies Amount is    ${item_data}[item_amount_locator]     ${item_data}[item_amount]   

Verifies Items order is 1 -
    [Arguments]    ${number}
    FOR    ${index}    IN RANGE    0    ${number}

        ${expected_number} =    Evaluate    ${index} + 1
        ${table_number_id} =    Set Variable    id=item-information-table-number-text-${index}

        Wait Until Element Is Visible    ${table_number_id}    timeout=5s
        
        ${actual_text} =    Get Text    ${table_number_id}
        Should Be Equal As Numbers    ${actual_text}    ${expected_number}
        
        Log To Console    Row ${expected_number}: element 'item-information-table-number-text-${index}' shows '${actual_text}'
    END



# Save

Click Save
    Click Button    id=save-invoice-entry-btn

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
    Wait Until Keyword Succeeds    5x    200ms    Element Text Should Be    id=job-no-label-0    ${job_no}

Verifies table REV is
    [Arguments]    ${rev_no}
    Wait Until Keyword Succeeds    5x    200ms    Element Text Should Be    id=rev-label-0   ${rev_no}

Verifies table Create By is
    [Arguments]    ${create_by_name}
    Wait Until Keyword Succeeds    5x    200ms    Element Text Should Be    id=create-by-label-0   ${create_by_name}
  
Verifies table Create Date is Current Date
    Store Expected Date Globally
    Use Stored Global Date

Store Expected Date Globally
    ${expected_date}=    Get Current Date    result_format=%d-%b-%Y
    Set Global Variable    ${GLOBAL_EXPECTED_DATE}    ${expected_date}

Use Stored Global Date
    ${actual_creation_date}=    Get Text    create-date-label-0
    Should Be Equal    ${actual_creation_date}    ${GLOBAL_EXPECTED_DATE}
    
Verifies table Transaction Type is
    [Arguments]    ${transaction_type}
    Wait Until Keyword Succeeds    5x    200ms    Element Text Should Be    id=transaction-type-label-0   ${transaction_type}

Verifies table Invoice Amount is  
    [Arguments]    ${invoice_amount}
    Wait Until Keyword Succeeds    5x    200ms    Element Text Should Be    id=invoice-amount-label-0   ${invoice_amount}

Verifies table Document Status is
    [Arguments]    ${doc_status}
    Wait Until Keyword Succeeds    5x    200ms    Element Text Should Be    id=document-status-label-0   ${doc_status}

Click Job NO.
    [Arguments]    ${job_no}
    Click Button    ${job_no}

Verifies Invoice 10 Items
    [Arguments]    ${file_path}
    @{csv_data}=    Read CSV File To List Of Dictionaries    ${file_path}
    
    FOR    ${item_data}    IN    @{csv_data}
        Verifies Item remaining    ${item_data}
    END
