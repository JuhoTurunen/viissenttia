*** Settings ***
Resource  resource.robot
Suite Setup      Open And Configure Browser
Suite Teardown   Close Browser
Test Setup       Go To Search Page

*** Variables ***
${VALID_KEY}        Person2021-
${VALID_AUTHOR}     Some Person
${VALID_TITLE}      Article Title
${VALID_JOURNAL}    Article Journal
${VALID_YEAR}       2021
${VALID_VOLUME}     1
${VALID_NUMBER}     2
${VALID_PAGES}      10-15
${VALID_MONTH}      12
${VALID_NOTE}       Article Note

*** Keywords ***

Select Search Field
    [Arguments]  ${field}
    Select From List By Label  xpath=//select[@name="search_field"]  ${field}

Search With Search Term
    [Arguments]   ${search_term}
    Input Text  name=search_term  ${search_term}
    Click Button  Search

Go To Add Citation Page
    Go To  ${ADD_CITATION_URL}

Go To Search Page
    Go To  ${SEARCH_URL}

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


Citation Can't Be Found Before Being Added
    Search With Search Term  This should return nothing 84309367
    Page Should Contain  No matching results

Add Article Citation
    Go To Add Citation Page
    Fill All Article Citation Fields    ${VALID_AUTHOR}  ${VALID_TITLE}  ${VALID_JOURNAL}  ${VALID_YEAR}  ${VALID_VOLUME}  ${VALID_NUMBER}  ${VALID_PAGES}  ${VALID_MONTH}  ${VALID_NOTE}
    Submit Citation Form

Check That Article Can Be Found With All Search
    Select Search Field  All
    Search With Search Term  ${VALID_AUTHOR}
    Page Should Contain  ${VALID_KEY}
    Page Should Contain  ${VALID_YEAR}
    Page Should Contain  ${VALID_AUTHOR}
    Page Should Contain  ${VALID_TITLE}

    Search With Search Term  ${VALID_YEAR}
    Page Should Contain  ${VALID_KEY}
    Page Should Contain  ${VALID_YEAR}
    Page Should Contain  ${VALID_AUTHOR}
    Page Should Contain  ${VALID_TITLE}

    Search With Search Term  ${VALID_TITLE}
    Page Should Contain  ${VALID_KEY}
    Page Should Contain  ${VALID_YEAR}
    Page Should Contain  ${VALID_AUTHOR}
    Page Should Contain  ${VALID_TITLE}

Check That Article Can Be Found With Author Search
    Select Search Field  Author
    Search With Search Term  ${VALID_AUTHOR}
    Page Should Contain  ${VALID_KEY}
    Page Should Contain  ${VALID_YEAR}
    Page Should Contain  ${VALID_AUTHOR}
    Page Should Contain  ${VALID_TITLE}

Check That Article Can Be Found With Year
    Select Search Field  Year
    Search With Search Term  ${VALID_YEAR}
    Page Should Contain  ${VALID_KEY}
    Page Should Contain  ${VALID_YEAR}
    Page Should Contain  ${VALID_AUTHOR}
    Page Should Contain  ${VALID_TITLE}

Check That Article Can Be Found With Title
    Select Search Field  Title
    Search With Search Term  ${VALID_TITLE}
    Page Should Contain  ${VALID_KEY}
    Page Should Contain  ${VALID_YEAR}
    Page Should Contain  ${VALID_AUTHOR}
    Page Should Contain  ${VALID_TITLE}

Delete Added Citation
    Search With Search Term  ${VALID_AUTHOR}
    Click Citation Brief  ${VALID_AUTHOR}
    Click Delete Button In Popup
    