*** Settings ***
Resource  resource.robot
Suite Setup      Open And Configure Browser
Suite Teardown   Close Browser
Test Setup       Go To Home Page

*** Variables ***
${VALID_KEY}        Article2024-1
${VALID_AUTHOR}     Test Article
${VALID_TITLE}      Delete Title
${VALID_JOURNAL}    Test Journal
${VALID_YEAR}       2024

*** Test Cases ***
Add And Delete Citation
    Go To Home Page
    Add Citation
    Go To Home Page
    Delete Existing Citation

*** Keywords ***
Go To Home Page
    Go To  ${HOME_URL}

Add Citation
    Go To  ${ADD_CITATION_URL}
    Fill Citation Form With Required Fields  ${VALID_AUTHOR}  ${VALID_TITLE}  ${VALID_JOURNAL}  ${VALID_YEAR}
    Submit Citation Formm

Fill Citation Form With Required Fields
    [Arguments]   ${author}  ${title}  ${journal}  ${year}
    Input Text  name=author  ${author}
    Input Text  name=title  ${title}
    Input Text  name=journal  ${journal}
    Input Text  name=year  ${year}

Submit Citation Formm
    Click Button  Create citation

Delete Existing Citation
    [Documentation]    Poistaa olemassa olevan viitteen
    Click Citation Brief
    Click Delete Button In Popup

*** Keywords ***
Click Citation Brief
    [Documentation]    Klikkaa citation_brief-elementtiä etusivulla
    Wait Until Element Is Visible  xpath=//div[contains(@class,'citation_brief') and contains(., '${VALID_TITLE}')]  timeout=0.5
    Click Element  xpath=//div[contains(@class,'citation_brief') and contains(., '${VALID_TITLE}')]

Click Delete Button In Popup
    [Documentation]    Klikkaa Delete-nappia popupissa
    Wait Until Element Is Visible  xpath=//div[contains(@class, 'popup') and contains(@class, 'shown')]  timeout=0.5
    Wait Until Element Is Visible  xpath=//div[contains(@class, 'popup') and contains(@class, 'shown')]//input[@value='Delete citation']  timeout=0.5
    Click Element  xpath=//div[contains(@class, 'popup') and contains(@class, 'shown')]//input[@value='Delete citation']
    Page Should Not Contain  ${VALID_KEY}
    Page Should Not Contain  ${VALID_AUTHOR}
    Page Should Not Contain  ${VALID_TITLE}
