*** Settings ***
Library    Collections
Library    CSVLibrary
Library    OperatingSystem
Library    SeleniumLibrary
Library    String
Library    DateTime
Resource    keyword-create-invoice.resource

*** Variables ***
${URL}    http://ge0-web:3000
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
    Verifies Item Table is    No data available
    Select Item Type By Detail
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