*** Settings ***
Library  SeleniumLibrary

*** Variables ***
${SERVER}     localhost:5001
${DELAY}      0.5 seconds
${HOME_URL}   http://${SERVER}
${BROWSER}    chrome
${HEADLESS}   false
${ADD_CITATION_URL}  http://${SERVER}/add_citation
${SEARCH_URL}  http://${SERVER}/search

*** Keywords ***
Open And Configure Browser
    IF  $BROWSER == 'chrome'
        ${options}  Evaluate  sys.modules['selenium.webdriver'].ChromeOptions()  sys
    ELSE IF  $BROWSER == 'firefox'
        ${options}  Evaluate  sys.modules['selenium.webdriver'].FirefoxOptions()  sys
    END
    IF  $HEADLESS == 'true'
        Set Selenium Speed  0.1
        Call Method  ${options}  add_argument  --headless
    ELSE
        Set Selenium Speed  ${DELAY}
    END
    Open Browser  browser=${BROWSER}  options=${options}
    Maximize Browser Window

Submit Citation Form
    Click Button  Create citation

Open optional fields
    Click Button  Show optional fields

Click Citation Brief
    [Documentation]    Click element citation_brief on home page
    [Arguments]  ${element}
    Wait Until Element Is Visible  xpath=//div[contains(@class,'citation_brief') and contains(., '${element}')]  timeout=0.5
    Click Element  xpath=//div[contains(@class,'citation_brief') and contains(., '${element}')]

Click Delete Button In Popup
    [Documentation]    Click Delete button on popup
    Wait Until Element Is Visible  xpath=//div[contains(@class, 'popup') and contains(@class, 'shown')]  timeout=0.5
    Wait Until Element Is Visible  xpath=//div[contains(@class, 'popup') and contains(@class, 'shown')]//input[@value='Delete citation']  timeout=0.5
    Click Element  xpath=//div[contains(@class, 'popup') and contains(@class, 'shown')]//input[@value='Delete citation']