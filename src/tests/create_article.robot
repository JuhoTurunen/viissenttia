*** Settings ***
Resource  resource.robot
Suite Setup      Open And Configure Browser
Suite Teardown   Close Browser
Test Setup       Go To Add Citation Page

*** Variables ***
${VALID_KEY}        Author2023
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
    Go To  ${HOME_URL}
    Click Link  Add Citation

Fill Citation Form With Required Fields
    [Arguments]   ${author}  ${title}  ${journal}  ${year}
    Input Text  name=author  ${author}
    Input Text  name=title  ${title}
    Input Text  name=journal  ${journal}
    Input Text  name=year  ${year}

Fill All Citation Fields
    [Arguments]   ${author}  ${title}  ${journal}  ${year}  ${volume}  ${number}  ${pages}  ${month}  ${note}
    Fill Citation Form With Required Fields ${author}  ${title}  ${journal}  ${year}
    Input Text  name=volume  ${volume}
    Input Text  name=number  ${number}
    Input Text  name=pages  ${pages}
    Input Text  name=month  ${month}
    Input Text  name=note  ${note}

Submit Citation Form
    Click Button  Create citation

Open optional fields
    Click Button  Show optional fields

*** Test Cases ***

Added Citation With All Fields Can Be Viewed
    Go To  ${HOME_URL}
    Page Should Contain  ${VALID_KEY}
    Page Should Contain  ${VALID_AUTHOR}
    Page Should Contain  ${VALID_TITLE}
    Page Should Contain  ${VALID_JOURNAL}
    Page Should Contain  ${VALID_YEAR}
    Page Should Contain  ${VALID_VOLUME}
    Page Should Contain  ${VALID_NUMBER}
    Page Should Contain  ${VALID_PAGES}
    Page Should Contain  ${VALID_MONTH}
    Page Should Contain  ${VALID_NOTE}

Cannot Send Citation Without Required Fields
    Submit Citation Form
    Page Should Not Contain  Failed to add citation

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
