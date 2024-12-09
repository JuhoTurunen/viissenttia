*** Settings ***
Resource  resource.robot
Suite Setup      Open And Configure Browser
Suite Teardown   Close Browser
Test Setup       Go To Add Citation Page

*** Variables ***
${VALID_KEY}        Author2023-1
${VALID_AUTHOR}     Test Author
${VALID_TITLE}      Test Title
${VALID_JOURNAL}    Test Journal
${VALID_YEAR}       2023
${VALID_VOLUME}     1
${VALID_NUMBER}     2
${VALID_PAGES}      10
${VALID_MONTH}      1
${VALID_NOTE}       Test note

*** Keywords ***

Go To Add Citation Page
    Go To  ${ADD_CITATION_URL}

Fill Citation Form With Required Fields
    [Arguments]   ${author}  ${title}  ${journal}  ${year}
    Input Text  name=author  ${author}
    Input Text  name=title  ${title}
    Input Text  name=journal  ${journal}
    Input Text  name=year  ${year}

Fill All Article Citation Fields
    [Arguments]   ${author}  ${title}  ${journal}  ${year}  ${volume}  ${number}  ${pages}  ${month}  ${note}
    Fill Citation Form With Required Fields  ${author}  ${title}  ${journal}  ${year}
    Open Optional Fields
    Input Text  name=volume  ${volume}
    Input Text  name=number  ${number}
    Input Text  name=pages  ${pages}
    Input Text  name=month  ${month}
    Input Text  name=note  ${note}

*** Test Cases ***

Added Article Citation With All Fields Can Be Viewed
    Fill All Article Citation Fields    ${VALID_AUTHOR}  ${VALID_TITLE}  ${VALID_JOURNAL}  ${VALID_YEAR}  ${VALID_VOLUME}  ${VALID_NUMBER}  ${VALID_PAGES}  ${VALID_MONTH}  ${VALID_NOTE}
    Submit Citation Form
    Go To  ${HOME_URL}
    Page Should Contain  ${VALID_KEY}
    Page Should Contain  ${VALID_AUTHOR}
    Page Should Contain  ${VALID_TITLE}

Invalid Year Format Is Not Accepted
    Fill Citation Form With Required Fields  ${VALID_AUTHOR}  ${VALID_TITLE}  ${VALID_JOURNAL}  abc
    Submit Citation Form
    Page Should Contain  Field year expects a number, received text

Invalid Volume Format Is Not Accepted
    Fill Citation Form With Required Fields  ${VALID_AUTHOR}  ${VALID_TITLE}  ${VALID_JOURNAL}  ${VALID_YEAR}
    Open optional fields
    Input Text  name=volume  abc
    Submit Citation Form
    Page Should Contain  Field volume expects a number, received text

Invalid Number Format Is Not Accepted
    Fill Citation Form With Required Fields  ${VALID_AUTHOR}  ${VALID_TITLE}  ${VALID_JOURNAL}  ${VALID_YEAR}
    Open optional fields
    Input Text  name=number  abc
    Submit Citation Form
    Page Should Contain  Field number expects a number, received text
