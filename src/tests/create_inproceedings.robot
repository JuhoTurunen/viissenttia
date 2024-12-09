*** Settings ***
Resource  resource.robot
Suite Setup      Open And Configure Browser
Suite Teardown   Close Browser
Test Setup       Go To Add Citation Page And Select Inproceedings

*** Variables ***
${VALID_KEY}            Author2023-1
${VALID_AUTHOR}         Inproceedings Author
${VALID_TITLE}          Inproceedings Title
${VALID_BOOKTITLE}      Inproceedings Booktitle
${VALID_YEAR}           2023
${VALID_PUBLISHER}      Inproceedings Publisher
${VALID_EDITOR}         Inproceedings Editor
${VALID_SERIES}         Inproceedings Series
${VALID_VOLUME}         5
${VALID_NUMBER}         2
${VALID_PAGES}          500-600
${VALID_ADDRESS}        Inproceedings Address
${VALID_MONTH}          11
${VALID_ORGANIZATION}   Inproceedings Organization

*** Keywords ***

Go To Add Citation Page And Select Inproceedings
    Go To  ${ADD_CITATION_URL}
    Select From List By Label  xpath=//select[@name="type"]  Inproceedings

Fill Citation Form With Required Fields
    [Arguments]   ${author}  ${title}  ${booktitle}  ${year}
    Input Text  name=author  ${author}
    Input Text  name=title  ${title}
    Input Text  name=booktitle  ${booktitle}
    Input Text  name=year  ${year}

Fill All Inproceedings Citation Fields
    [Arguments]   ${author}  ${title}  ${booktitle}  ${year}  ${publisher}  ${editor}  ${series}  ${volume}  ${number}  ${pages}  ${address}  ${month}  ${organization}
    Fill Citation Form With Required Fields  ${author}  ${title}  ${booktitle}  ${year}
    Open Optional Fields
    Input Text  name=publisher  ${publisher}
    Input Text  name=editor  ${editor}
    Input Text  name=series  ${series}
    Input Text  name=volume  ${volume}
    Input Text  name=number  ${number}
    Input Text  name=pages  ${pages}
    Input Text  name=address  ${address}
    Input Text  name=month  ${month}
    Input Text  name=organization  ${organization}

*** Test Cases ***

Cannot Send Citation Without Required Fields
    Submit Citation Form
    Page Should Not Contain  Failed to add citation

Added Inproceedings Citation With All Fields Can Be Viewed
    Fill All Inproceedings Citation Fields    ${VALID_AUTHOR}  ${VALID_TITLE}  ${VALID_BOOKTITLE}  ${VALID_YEAR}  ${VALID_PUBLISHER}  ${VALID_EDITOR}  ${VALID_SERIES}  ${VALID_VOLUME}  ${VALID_NUMBER}  ${VALID_PAGES}  ${VALID_ADDRESS}  ${VALID_MONTH}  ${VALID_ORGANIZATION}
    Submit Citation Form
    Go To  ${HOME_URL}
    Page Should Contain  ${VALID_KEY}
    Page Should Contain  ${VALID_AUTHOR}
    Page Should Contain  ${VALID_TITLE}

Invalid Year Format Is Not Accepted
    Fill Citation Form With Required Fields  ${VALID_AUTHOR}  ${VALID_TITLE}  ${VALID_BOOKTITLE}  abc  
    Submit Citation Form
    Page Should Contain  Field year expects a number, received text

Invalid Month Format Is Not Accepted
    Fill Citation Form With Required Fields  ${VALID_AUTHOR}  ${VALID_TITLE}  ${VALID_BOOKTITLE}  ${VALID_YEAR}
    Open Optional Fields
    Input Text  name=month  abc
    Submit Citation Form
    Page Should Contain  Field month expects a number, received text

Invalid Number Format Is Not Accepted
    Fill Citation Form With Required Fields  ${VALID_AUTHOR}  ${VALID_TITLE}  ${VALID_BOOKTITLE}  ${VALID_YEAR}
    Open Optional Fields
    Input Text  name=number  abc
    Submit Citation Form
    Page Should Contain  Field number expects a number, received text

Invalid Volume Format Is Not Accepted
    Fill Citation Form With Required Fields  ${VALID_AUTHOR}  ${VALID_TITLE}  ${VALID_BOOKTITLE}  ${VALID_YEAR}
    Open Optional Fields
    Input Text  name=volume  abc
    Submit Citation Form
    Page Should Contain  Field volume expects a number, received text
