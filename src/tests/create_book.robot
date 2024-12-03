*** Settings ***
Resource  resource.robot
Suite Setup      Open And Configure Browser
Suite Teardown   Close Browser
Test Setup       Go To Add Citation Page And Select Book

*** Variables ***
${VALID_KEY}        Bookauthor2020
${VALID_AUTHOR}     Test Bookauthor
${VALID_TITLE}      Test Book Title
${VALID_YEAR}       2020
${VALID_PUBLISHER}  Test book publisher
${VALID_VOLUME}     1
${VALID_SERIES}     Test book series
${VALID_ADDRESS}    Test publisher address
${VALID_EDITION}    2
${VALID_NOTE}       Test book note

*** Keywords ***

Go To Add Citation Page And Select Book
    Go To  ${ADD_CITATION_URL}
    Select From List By Label  xpath=//select[@name="type"]  Book

Fill Citation Form With Required Fields
    [Arguments]   ${author}  ${title}  ${year}  ${publisher}
    Input Text  name=author  ${author}
    Input Text  name=title  ${title}
    Input Text  name=year  ${year}
    Input Text  name=publisher  ${publisher}

Fill All Citation Fields
    [Arguments]   ${author}  ${title}  ${year}  ${publisher}  ${volume}  ${series}  ${address}  ${edition}  ${note}
    Fill Citation Form With Required Fields ${author}  ${title}  ${year}  ${publisher}
    Input Text  name=volume  ${volume}
    Input Text  name=series  ${series}
    Input Text  name=address  ${address}
    Input Text  name=edition  ${edition}
    Input Text  name=note  ${note}

Submit Citation Form
    Click Button  Create citation

Open Optional Fields
    Click Button  Show optional fields

*** Test Cases ***

#Added Citation With All Fields Can Be Viewed
#    Go To  ${HOME_URL}
#    Page Should Contain  ${VALID_KEY}
#    Page Should Contain  ${VALID_AUTHOR}
#    Page Should Contain  ${VALID_TITLE}
#    Page Should Contain  ${VALID_YEAR}
#    Page Should Contain  ${VALID_PUBLISHER}
#    Page Should Contain  ${VALID_VOLUME}
#    Page Should Contain  ${VALID_SERIES}
#    Page Should Contain  ${VALID_ADDRESS}
#    Page Should Contain  ${VALID_EDITION}
#    Page Should Contain  ${VALID_NOTE}

Cannot Send Citation Without Required Fields
    Submit Citation Form
    Page Should Not Contain  Failed to add citation

Invalid Year Format Is Not Accepted
    Fill Citation Form With Required Fields  ${VALID_AUTHOR}  ${VALID_TITLE}  abc  ${VALID_PUBLISHER}
    Submit Citation Form
    Page Should Contain  Field year expects a number, received text

Invalid Volume Format Is Not Accepted
    Fill Citation Form With Required Fields  ${VALID_AUTHOR}  ${VALID_TITLE}  ${VALID_YEAR}  ${VALID_PUBLISHER}
    Open Optional Fields
    Input Text  name=volume  abc
    Submit Citation Form
    Page Should Contain  Field volume expects a number, received text

Invalid Edition Format Is Not Accepted
    Fill Citation Form With Required Fields  ${VALID_AUTHOR}  ${VALID_TITLE}  ${VALID_YEAR}  ${VALID_PUBLISHER}
    Open Optional Fields
    Input Text  name=edition  abc
    Submit Citation Form
    Page Should Contain  Field edition expects a number, received text
