*** Settings ***
Resource  resource.robot
Suite Setup      Open And Configure Browser
Suite Teardown   Close Browser
Test Setup       Go To Add Citation Page

*** Variables ***
${VALID_KEY}        Article2021-
${VALID_AUTHOR}     Author Article
${VALID_TITLE}      Title Article
${VALID_JOURNAL}    Journal Article
${VALID_YEAR}       2021
${VALID_VOLUME}     1
${VALID_NUMBER}     2
${VALID_PAGES}      10-15
${VALID_MONTH}      12
${VALID_NOTE}       Note Article

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

Cannot Send Citation Without Required Fields
    [Documentation]    Tests that user cannot add a new article type citation without filling in all mandatory fields
    Submit Citation Form
    Page Should Not Contain  Successfully added citation

Invalid Year Format Is Not Accepted
    [Documentation]    Tests that user cannot add a new article type citation when trying to submit a string as year
    Fill Citation Form With Required Fields  ${VALID_AUTHOR}  ${VALID_TITLE}  ${VALID_JOURNAL}  abc
    Submit Citation Form
    Page Should Contain  Field year expects a number, received text

Invalid Volume Format Is Not Accepted
    [Documentation]    Tests that user cannot add a new article type citation when trying to submit a string as volume
    Fill Citation Form With Required Fields  ${VALID_AUTHOR}  ${VALID_TITLE}  ${VALID_JOURNAL}  ${VALID_YEAR}
    Open optional fields
    Input Text  name=volume  abc
    Submit Citation Form
    Page Should Contain  Field volume expects a number, received text

Invalid Number Format Is Not Accepted
    [Documentation]    Tests that user cannot add a new article type citation when trying to submit a string as number
    Fill Citation Form With Required Fields  ${VALID_AUTHOR}  ${VALID_TITLE}  ${VALID_JOURNAL}  ${VALID_YEAR}
    Open optional fields
    Input Text  name=number  abc
    Submit Citation Form
    Page Should Contain  Field number expects a number, received text

Can Add Citation With All Fields
    [Documentation]    Tests that user can add a new article type citation using all possible fields
    Fill All Article Citation Fields    ${VALID_AUTHOR}  ${VALID_TITLE}  ${VALID_JOURNAL}  ${VALID_YEAR}  ${VALID_VOLUME}  ${VALID_NUMBER}  ${VALID_PAGES}  ${VALID_MONTH}  ${VALID_NOTE}
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
