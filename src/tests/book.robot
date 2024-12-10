*** Settings ***
Resource  resource.robot
Suite Setup      Open And Configure Browser
Suite Teardown   Close Browser
Test Setup       Go To Add Citation Page And Select Book

*** Variables ***
${VALID_KEY}        Book2022-
${VALID_AUTHOR}     Author Book
${VALID_TITLE}      Title Book
${VALID_YEAR}       2022
${VALID_PUBLISHER}  Publisher Book
${VALID_SERIES}     Series Book
${VALID_VOLUME}     5
${VALID_EDITION}    2
${VALID_ADDRESS}    Address Book
${VALID_NOTE}       Note Book

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

Cannot Add Citation Without Filling Required Fields
    [Documentation]    Tests that user cannot add a new book type citation without filling in all mandatory fields
    Submit Citation Form
    Page Should Not Contain  Successfully added citation

Invalid Year Format Is Not Accepted
    [Documentation]    Tests that user cannot add a new book type citation when trying to submit a string as year
    Fill Citation Form With Required Fields  ${VALID_AUTHOR}  ${VALID_TITLE}  ${VALID_PUBLISHER}  abc
    Submit Citation Form
    Page Should Contain  Field year expects a number, received text

Invalid Volume Format Is Not Accepted
    [Documentation]    Tests that user cannot add a new book type citation when trying to submit a string as volume
    Fill Citation Form With Required Fields  ${VALID_AUTHOR}  ${VALID_TITLE}  ${VALID_PUBLISHER}  ${VALID_YEAR}
    Open Optional Fields
    Input Text  name=volume  abc
    Submit Citation Form
    Page Should Contain  Field volume expects a number, received text

Can Add Citation With All Fields
    [Documentation]    Tests that user can add a new book type citation using all possible fields
    Fill All Book Citation Fields    ${VALID_AUTHOR}  ${VALID_TITLE}  ${VALID_PUBLISHER}  ${VALID_YEAR}  ${VALID_SERIES}  ${VALID_VOLUME}  ${VALID_EDITION}  ${VALID_ADDRESS}  ${VALID_NOTE}
    Submit Citation Form
    Page Should Contain  Successfully added citation

Can View Added Citation
    [Documentation]    Tests that the existing citation created in the previous test can be viewed
    Go To  ${HOME_URL}
    Page Should Contain  ${VALID_KEY}
    Page Should Contain  ${VALID_AUTHOR}
    Page Should Contain  ${VALID_TITLE}

Can Delete Added Citation
    [Documentation]    Tests that the existing citation created in the earlier test can be deleted
    Go To  ${HOME_URL}
    Click Citation Brief  ${VALID_KEY}
    Click Delete Button In Popup
    Page Should Not Contain  ${VALID_KEY}

