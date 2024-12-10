*** Settings ***
Resource  resource.robot
Suite Setup      Open And Configure Browser
Suite Teardown   Close Browser
Test Setup       Go To Add Citation Page And Select Manual

*** Variables ***
${VALID_KEY}          Manual2024-1
${VALID_AUTHOR}       Author Manual
${VALID_TITLE}        Manual Title
${VALID_ORGANIZATION}  Manual Organization
${VALID_YEAR}         2024
${VALID_ADDRESS}      Manual Address
${VALID_EDITION}      1
${VALID_MONTH}        1
${VALID_NOTE}         Manual Note
${VALID_ANNOTE}       Manual Annote

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

Click Citation Brief
    [Documentation]    Click element citation_brief on home page
    Wait Until Element Is Visible  xpath=//div[contains(@class,'citation_brief') and contains(., '${VALID_KEY}')]  timeout=0.5
    Click Element  xpath=//div[contains(@class,'citation_brief') and contains(., '${VALID_KEY}')]

Click Delete Button In Popup
    [Documentation]    Click Delete button on popup
    Wait Until Element Is Visible  xpath=//div[contains(@class, 'popup') and contains(@class, 'shown')]  timeout=0.5
    Wait Until Element Is Visible  xpath=//div[contains(@class, 'popup') and contains(@class, 'shown')]//input[@value='Delete citation']  timeout=0.5
    Click Element  xpath=//div[contains(@class, 'popup') and contains(@class, 'shown')]//input[@value='Delete citation']


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

Can View Added Manual Citation
    [Documentation]    Tests that the existing citation created in the previous test can be viewed
    Go To  ${HOME_URL}
    Page Should Contain  ${VALID_KEY}

Can Delete Added Manual Citation
    [Documentation]    Tests that the existing citation created in the earlier test can be deleted
    Go To  ${HOME_URL}
    Click Citation Brief
    Click Delete Button In Popup
    Page Should Not Contain  ${VALID_KEY}
