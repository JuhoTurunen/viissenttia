*** Settings ***
Resource  resource.robot
Suite Setup      Open And Configure Browser
Suite Teardown   Close Browser
Test Setup       Go To Add Citation Page And Select Manual

*** Variables ***
${VALID_KEY}          Author2023-1
${VALID_AUTHOR}       Manual Author
${VALID_TITLE}        Manual Title
${VALID_ORGANIZATION}  Manual Organization
${VALID_YEAR}         2023
${VALID_ADDRESS}      Test Address
${VALID_EDITION}      1
${VALID_MONTH}        1
${VALID_NOTE}         Test note for manual
${VALID_ANNOTE}       Test annote for manual

*** Keywords ***

Go To Add Citation Page And Select Manual
    Go To  ${ADD_CITATION_URL}
    Select From List By Label  xpath=//select[@name="type"]  Manual

Fill Manual Citation Form With Required Fields
    Go To Add Citation Page And Select Manual
    [Arguments]   ${author}  ${title}  ${organization}  ${year}
    Input Text  name=author  ${author}
    Input Text  name=title  ${title}
    Input Text  name=organization  ${organization}
    Input Text  name=year  ${year}

Fill All Manual Citation Fields
    [Arguments]   ${author}  ${title}  ${organization}  ${year}  ${address}  ${edition}  ${month}  ${note}  ${annote}
    Fill Manual Citation Form With Required Fields  ${author}  ${title}  ${organization}  ${year}
    Open Optional Fields
    Input Text  name=address  ${address}
    Input Text  name=edition  ${edition}
    Input Text  name=month  ${month}
    Input Text  name=note  ${note}
    Input Text  name=annote  ${annote}

*** Test Cases ***

Cannot Send Citation Without Required Fields
    Go To Add Citation Page And Select Manual
    Page Should Not Contain  Failed to add citation

Added Manual Citation With All Fields Can Be Viewed
    Fill All Manual Citation Fields    ${VALID_AUTHOR}  ${VALID_TITLE}  ${VALID_ORGANIZATION}  ${VALID_YEAR}  ${VALID_ADDRESS}  ${VALID_EDITION}  ${VALID_MONTH}  ${VALID_NOTE}  ${VALID_ANNOTE}
    Submit Citation Form
    Go To  ${HOME_URL}
    Page Should Contain  ${VALID_KEY}
    Page Should Contain  ${VALID_AUTHOR}
    Page Should Contain  ${VALID_TITLE}

Invalid Year Format Is Not Accepted
    Go To Add Citation Page And Select Manual
    Fill Manual Citation Form With Required Fields  ${VALID_AUTHOR}  ${VALID_TITLE}  ${VALID_ORGANIZATION}  abc
    Submit Citation Form
    Page Should Contain  Field year expects a number, received text

Invalid Month Format Is Not Accepted
    Go To Add Citation Page And Select Manual
    Fill Manual Citation Form With Required Fields  ${VALID_AUTHOR}  ${VALID_TITLE}  ${VALID_ORGANIZATION}  ${VALID_YEAR}
    Open Optional Fields
    Input Text  name=month  abc
    Submit Citation Form
    Page Should Contain  Field month expects a number, received text