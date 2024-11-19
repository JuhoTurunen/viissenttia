*** Settings ***
Resource  resource.robot
Suite Setup      Open And Configure Browser
Suite Teardown   Close Browser
Test Setup       Reset App And Go To Add Citation Page

*** Variables ***
${VALID_KEY}        testkey123
${VALID_AUTHOR}     Test Author
${VALID_TITLE}      Test Title
${VALID_JOURNAL}    Test Journal
${VALID_YEAR}       2023
${VALID_VOLUME}     1
${VALID_NUMBER}     2
${VALID_PAGES}      10
${VALID_MONTH}      1
${VALID_NOTE}       Test note

*** Keywords ***
Reset App And Go To Add Citation Page
    Reset App
    Go To Add Citation Page

Go To Add Citation Page
    Go To  ${HOME_URL}
    Click Button  Add a new citation

Fill Citation Form With Required Fields
    [Arguments]  ${key}  ${author}  ${title}  ${journal}  ${year}
    Input Text  name=key  ${key}
    Input Text  name=author  ${author}
    Input Text  name=title  ${title}
    Input Text  name=journal  ${journal}
    Input Text  name=year  ${year}

Fill All Citation Fields
    [Arguments]  ${key}  ${author}  ${title}  ${journal}  ${year}  ${volume}  ${number}  ${pages}  ${month}  ${note}
    Fill Citation Form With Required Fields  ${key}  ${author}  ${title}  ${journal}  ${year}
    Input Text  name=volume  ${volume}
    Input Text  name=number  ${number}
    Input Text  name=pages  ${pages}
    Input Text  name=month  ${month}
    Input Text  name=note  ${note}

Submit Citation Form
    Click Button  Create

*** Test Cases ***
Add Citation Page Can Be Opened
    Go To Add Citation Page
    Page Should Contain  Create a new citation

# Can Add Valid Article Citation With Required Fields
#     Fill Citation Form With Required Fields  ${VALID_KEY}  ${VALID_AUTHOR}  ${VALID_TITLE}  ${VALID_JOURNAL}  ${VALID_YEAR}
#     Submit Citation Form
#     Page Should Contain  Successfully added citation

# Can Add Valid Article Citation With All Fields
#     Fill All Citation Fields  
#     ...  ${VALID_KEY}  
#     ...  ${VALID_AUTHOR}  
#     ...  ${VALID_TITLE}  
#     ...  ${VALID_JOURNAL}  
#     ...  ${VALID_YEAR}
#     ...  ${VALID_VOLUME}
#     ...  ${VALID_NUMBER}
#     ...  ${VALID_PAGES}
#     ...  ${VALID_MONTH}
#     ...  ${VALID_NOTE}
#     Submit Citation Form
#     Page Should Contain  Successfully added citation

# Added Citation With All Fields Can Be Viewed
#     Fill All Citation Fields  
#     ...  ${VALID_KEY}  
#     ...  ${VALID_AUTHOR}  
#     ...  ${VALID_TITLE}  
#     ...  ${VALID_JOURNAL}  
#     ...  ${VALID_YEAR}
#     ...  ${VALID_VOLUME}
#     ...  ${VALID_NUMBER}
#     ...  ${VALID_PAGES}
#     ...  ${VALID_MONTH}
#     ...  ${VALID_NOTE}
#     Submit Citation Form
#     Click Button  Return to frontpage
#     Click Button  View citations
#     Page Should Contain  ${VALID_KEY}
#     Page Should Contain  ${VALID_AUTHOR}
#     Page Should Contain  ${VALID_TITLE}
#     Page Should Contain  ${VALID_JOURNAL}
#     Page Should Contain  ${VALID_YEAR}
#     Page Should Contain  ${VALID_VOLUME}
#     Page Should Contain  ${VALID_NUMBER}
#     Page Should Contain  ${VALID_PAGES}
#     Page Should Contain  ${VALID_MONTH}
#     Page Should Contain  ${VALID_NOTE}

# Can Add Citation With Only Volume As Optional Field
#     Fill Citation Form With Required Fields  ${VALID_KEY}  ${VALID_AUTHOR}  ${VALID_TITLE}  ${VALID_JOURNAL}  ${VALID_YEAR}
#     Input Text  name=volume  ${VALID_VOLUME}
#     Submit Citation Form
#     Page Should Contain  Successfully added citation

# Can Add Citation With Only Number As Optional Field
#     Fill Citation Form With Required Fields  ${VALID_KEY}  ${VALID_AUTHOR}  ${VALID_TITLE}  ${VALID_JOURNAL}  ${VALID_YEAR}
#     Input Text  name=number  ${VALID_NUMBER}
#     Submit Citation Form
#     Page Should Contain  Successfully added citation

# Can Add Citation With Only Pages As Optional Field
#     Fill Citation Form With Required Fields  ${VALID_KEY}  ${VALID_AUTHOR}  ${VALID_TITLE}  ${VALID_JOURNAL}  ${VALID_YEAR}
#     Input Text  name=pages  ${VALID_PAGES}
#     Submit Citation Form
#     Page Should Contain  Successfully added citation

# Can Add Citation With Only Month As Optional Field
#     Fill Citation Form With Required Fields  ${VALID_KEY}  ${VALID_AUTHOR}  ${VALID_TITLE}  ${VALID_JOURNAL}  ${VALID_YEAR}
#     Input Text  name=month  ${VALID_MONTH}
#     Submit Citation Form
#     Page Should Contain  Successfully added citation

# Can Add Citation With Only Note As Optional Field
#     Fill Citation Form With Required Fields  ${VALID_KEY}  ${VALID_AUTHOR}  ${VALID_TITLE}  ${VALID_JOURNAL}  ${VALID_YEAR}
#     Input Text  name=note  ${VALID_NOTE}
#     Submit Citation Form
#     Page Should Contain  Successfully added citation

Cannot Add Citation Without Required Fields
    Fill Citation Form With Required Fields  ${EMPTY}  ${EMPTY}  ${EMPTY}  ${EMPTY}  ${EMPTY}
    Submit Citation Form
    Page Should Contain  Failed to add citation

Invalid Year Format Is Not Accepted
    Fill Citation Form With Required Fields  ${VALID_KEY}  ${VALID_AUTHOR}  ${VALID_TITLE}  ${VALID_JOURNAL}  abc
    Submit Citation Form
    Page Should Contain  Failed to add citation

Invalid Volume Format Is Not Accepted
    Fill Citation Form With Required Fields  ${VALID_KEY}  ${VALID_AUTHOR}  ${VALID_TITLE}  ${VALID_JOURNAL}  ${VALID_YEAR}
    Input Text  name=volume  abc
    Submit Citation Form
    Page Should Contain  Failed to add citation

Invalid Number Format Is Not Accepted
    Fill Citation Form With Required Fields  ${VALID_KEY}  ${VALID_AUTHOR}  ${VALID_TITLE}  ${VALID_JOURNAL}  ${VALID_YEAR}
    Input Text  name=number  abc
    Submit Citation Form
    Page Should Contain  Failed to add citation
