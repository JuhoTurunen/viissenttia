*** Settings ***
Resource  resource.robot
Suite Setup      Open And Configure Browser
Suite Teardown   Close Browser

*** Test Cases ***
App launches to home page
    Go To  ${HOME_URL}
    Title Should Be  Citation app

Add a new citation button works
    Go To  ${HOME_URL}
    Click Button  Add a new citation
    Page Should Contain  Create a new citation

Return to frontpage works from add citations
    Click Link  Home
    Title Should Be  Citation app
    
View citations button works
    Go To  ${HOME_URL}
    Click Button  View citations
    Page Should Contain  Citations

Return to frontpage works from view citations
    Click Link  Home
    Title Should Be  Citation app