*** Settings ***
Resource  resource.robot
Suite Setup      Open And Configure Browser
Suite Teardown   Close Browser
Test Setup       Go To Add Citation Page And Select Book

*** Variables ***
${VALID_KEY}        Author2022-1
${VALID_AUTHOR}     Book Author
${VALID_TITLE}      Book Title
${VALID_YEAR}       2022
${VALID_PUBLISHER}  Book Publisher
${VALID_SERIES}     Book Series
${VALID_VOLUME}     5
${VALID_EDITION}    2
${VALID_ADDRESS}    Book Address
${VALID_NOTE}       Book Note

*** Keywords ***

Go To Add Citation Page And Select Book
    Go To  ${ADD_CITATION_URL}
    Select From List By Label  xpath=//select[@name="type"]  Book

Fill Citation Form With Required Fields
    [Arguments]   ${author}  ${title}  ${publisher}  ${year}
    Input Text  name=author  ${author}
    Input Text  name=title  ${title}
    Input Text  name=publisher  ${publisher}
    Input Text  name=year  ${year}

Fill All Book Citation Fields
    [Arguments]   ${author}  ${title}  ${publisher}  ${year}  ${series}  ${volume}  ${edition}  ${address}  ${note}
    Fill Citation Form With Required Fields  ${author}  ${title}  ${publisher}  ${year}
    Open Optional Fields
    Input Text  name=series  ${series}
    Input Text  name=volume  ${volume}
    Input Text  name=edition  ${edition}
    Input Text  name=address  ${address}
    Input Text  name=note  ${note}

*** Test Cases ***

Cannot Send Citation Without Required Fields
    Submit Citation Form
    Page Should Not Contain  Failed to add citation

Added Book Citation With All Fields Can Be Viewed
    Fill All Book Citation Fields    ${VALID_AUTHOR}  ${VALID_TITLE}  ${VALID_PUBLISHER}  ${VALID_YEAR}  ${VALID_SERIES}  ${VALID_VOLUME}  ${VALID_EDITION}  ${VALID_ADDRESS}  ${VALID_NOTE}
    Submit Citation Form
    Go To  ${HOME_URL}
    Page Should Contain  ${VALID_KEY}
    Page Should Contain  ${VALID_AUTHOR}
    Page Should Contain  ${VALID_TITLE}

Invalid Year Format Is Not Accepted
    Fill Citation Form With Required Fields  ${VALID_AUTHOR}  ${VALID_TITLE}  ${VALID_PUBLISHER}  abc
    Submit Citation Form
    Page Should Contain  Field year expects a number, received text

Invalid Volume Format Is Not Accepted
    Fill Citation Form With Required Fields  ${VALID_AUTHOR}  ${VALID_TITLE}  ${VALID_PUBLISHER}  ${VALID_YEAR}
    Open Optional Fields
    Input Text  name=volume  abc
    Submit Citation Form
    Page Should Contain  Field volume expects a number, received text
