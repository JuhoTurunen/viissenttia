*** Settings ***
Resource  resource.robot
Suite Setup      Open And Configure Browser
Suite Teardown   Close Browser

*** Test Cases ***
App launches to home page
    Go To  ${HOME_URL}
    Title Should Be  Citation Manager

Add a new citation button works
    Go To  ${HOME_URL}
    Click Link  Add Citation
    Title Should Be  Create a new citation

Return to frontpage works from add citations
    Click Link  Home
    Title Should Be  Citation Manager