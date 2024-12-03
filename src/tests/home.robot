*** Settings ***
Resource  resource.robot
Suite Setup      Open And Configure Browser
Suite Teardown   Close Browser

*** Variables ***


*** Test Cases ***
App launches to home page
    Go To  ${HOME_URL}
    Title Should Be  Citation Manager

Add a new citation button works
    Go To  ${HOME_URL}
    Click Link  Add Citation
    Page Should Contain  Show optional fields

Return to frontpage works from add citations
    Click Link  Home
    Title Should Be  Citation Manager

Saved citations are displayed
    Go To  ${HOME_URL}
    Page Should Contain  Saved citations
    Page Should Contain Element  xpath://div[@id="citation_container"]
    Page Should Contain Element  xpath://div[@class="citation_type"]

Verify popup field names
    Go To  ${HOME_URL}
    Click Element  xpath://div[@class="citation_brief"]
    Page Should Contain  Key:
    Page Should Contain  Type:
    Page Should Contain  Author:
    Page Should Contain  Year:
    Page Should Contain  Title:
