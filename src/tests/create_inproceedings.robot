*** Settings ***
Resource  resource.robot
Suite Setup      Open And Configure Browser
Suite Teardown   Close Browser
Test Setup       Go To Add Citation Page And Select Inproceedings

*** Variables ***
${VALID_KEY}        Bookauthor2021
${VALID_AUTHOR}     Test Inproceedings Author
${VALID_TITLE}      Test Inproceedings Title
${VALID_BOOKTITLE}  Test Booktitle
${VALID_YEAR}       2021
${VALID_PUBLISHER}  Test book publisher
${VALID_VOLUME}     5
${VALID_SERIES}     Test book series
${VALID_ADDRESS}    Test publisher address
${VALID_PAGES}      500-600
${VALID_EDITOR}     Hannu Hanhi
${VALID_NOTE}       Test book note

*** Keywords ***

Go To Add Citation Page And Select Inproceedings
    Go To  ${ADD_CITATION_URL}
    Select From List By Label  xpath=//select[@name="type"]  Inproceedings

Fill Citation Form With Required Fields
    [Arguments]   ${author}  ${title}  ${booktitle}  ${year}
    Input Text  name=author  ${author}
    Input Text  name=title  ${title}
    Input Text  name=booktitle  ${booktitle}
    Input Text  name=year  ${year}

Fill All Citation Fields
    [Arguments]   ${author}  ${title}  ${year}  ${publisher}  ${volume}  ${series}  ${address}  ${note}  ${booktitle}  ${editor}  ${organization}  ${month}  ${pages}  ${number}
    Fill Citation Form With Required Fields ${author}  ${title}  ${booktitle}  ${year}
    Input Text  name=editor  ${editor}
    Input Text  name=volume  ${volume}
    Input Text  name=series  ${series}
    Input Text  name=address  ${address}
    Input Text  name=number  ${number}
    Input Text  name=pages  ${pages}
    Input Text  name=month ${month}
    Input Text  name=publisher  ${publisher}
    Input Text  name=organization  ${organization}
    Input Text  name=note  ${note}

Submit Citation Form
    Click Button  Create citation

Open Optional Fields
    Click Button  Show optional fields

*** Test Cases ***

Cannot Send Citation Without Required Fields
    Submit Citation Form
    Page Should Not Contain  Failed to add citation

Invalid Year Format Is Not Accepted
    Fill Citation Form With Required Fields  ${VALID_AUTHOR}  ${VALID_TITLE}  ${VALID_BOOKTITLE}  abc  
    Submit Citation Form
    Page Should Contain  Field year expects a number, received text

Invalid Month Format Is Not Accepted
    Fill Citation Form With Required Fields  ${VALID_AUTHOR}  ${VALID_TITLE}  ${VALID_BOOKTITLE}  ${VALID_YEAR}
    Open Optional Fields
    Input Text  name=month  abc
    Submit Citation Form
    Page Should Contain  Field month expects a number, received text

Invalid Number Format Is Not Accepted
    Fill Citation Form With Required Fields  ${VALID_AUTHOR}  ${VALID_TITLE}  ${VALID_BOOKTITLE}  ${VALID_YEAR}
    Open Optional Fields
    Input Text  name=number  abc
    Submit Citation Form
    Page Should Contain  Field number expects a number, received text

Invalid Volume Format Is Not Accepted
    Fill Citation Form With Required Fields  ${VALID_AUTHOR}  ${VALID_TITLE}  ${VALID_BOOKTITLE}  ${VALID_YEAR}
    Open Optional Fields
    Input Text  name=volume  abc
    Submit Citation Form
    Page Should Contain  Field volume expects a number, received text
