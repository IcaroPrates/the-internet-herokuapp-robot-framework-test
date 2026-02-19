*** Settings ***
Documentation    Project High Level Keywords.
Library           SeleniumLibrary  run_on_failure=Take Screenshots Browser
Library           DateTime
Library           String
Library           Collections
Library           OperatingSystem
Library           ../../Libraries/jwt_automation.py
Resource          kws_lowlevel.resource
Variables         ../../Resources/Variables/CommonVariables.py
Variables         ../../Resources/Locators/PageObjectElements/CommonElements.py

*** Keywords ***

Open Application
    [Arguments]  ${URL}
    [Documentation]   Generic test setup to switch between local and remote SeleniumLibrary.Open Browser

    Run Keyword If    '${environmentToRunTest}'=='LOCAL'     Open Chrome  ${URL}
    ...     ELSE IF   '${environmentToRunTest}'=='HEADLESS'   Open Headless Chrome  ${URL}
    ...     ELSE      Log       testSetup went wrong. Check the value of the variable 'environmentToRunTest'.
    Set Window Size     1920    1080

Open Chrome
    [Arguments]      ${URL}
    [Documentation]  Open a chrome browser. 

    Open Browser    ${URL}      chrome     options=add_argument("--disable-search-engine-choice-screen"); add_argument("--ignore-certificate-errors"); add_argument("--disable-sandbox"); add_argument("--disable-dev-shm-usage"); add_argument("--disable-blink-features=AutomationControlled"); add_argument("--disable-popup-blocking"); add_argument("--disable-notifications"); add_argument("--disable-infobars"); add_argument("--no-default-browser-check"); add_argument("--no-first-run")
    Configure Download Folder
    # ${jwt_token}    generate_jwt
    # Add Token To Header    ${jwt_token}

Open Headless Chrome
    [Arguments]      ${URL}
    [Documentation]  Open a headless chrome browser. 

    Log    message=Opening the browser in Headless mode
    SeleniumLibrary.Open Browser    ${URL}      headlesschrome      options=add_argument("--headless=new"); add_argument("--disable-sandbox"); add_argument("--disable-dev-shm-usage"); add_argument("--disable-blink-features=AutomationControlled"); add_argument("--ignore-certificate-errors"); add_argument("--disable-popup-blocking"); add_argument("--disable-notifications"); add_argument("--disable-infobars"); add_argument("--no-default-browser-check"); add_argument("--no-first-run")
    Configure Download Folder
    # ${jwt_token}    generate_jwt
    # Add Token To Header    ${jwt_token}

Get Jwt Token From Csv
    [Arguments]    ${csv_path}
    [Documentation]    Reads the JWT token from a CSV file with header and one data row.

    ${csv_content}=    Get File    ${csv_path}
    ${lines}=    Split To Lines    ${csv_content}
    ${token}=    Get From List    ${lines}    1
    ${token}=    Replace String    ${token}    "    ${EMPTY}
    RETURN    ${token}

Open Application With Jwt
    [Arguments]    ${URL}    ${csv_path}
    [Documentation]   Opens the browser and appends the JWT token from CSV to the URL for a single test case.

    Run Keyword If    '${environmentToRunTest}'=='LOCAL'     Open Chrome  ${URL}
    ...     ELSE IF   '${environmentToRunTest}'=='HEADLESS'   Open Headless Chrome  ${URL}
    ...     ELSE      Log       testSetup went wrong. Check the value of the variable 'environmentToRunTest'.
    Set Window Size     1920    1080

    ${jwt_token}=    Get Jwt Token From Csv    ${csv_path}
    Add Token To Header    ${jwt_token}

Add Token To Header
    [Arguments]     ${token}
    ${headers}=     Create Dictionary      Authorization=Bearer ${token}
    Execute Javascript      window.location.href = window.location.href + '?Authorization=${token}';

Configure Download Folder
    [Documentation]    Configures Chrome to use the project's Data/Files/Downloads folder for downloads.
    ...    Uses Chrome DevTools Protocol to set the download behavior.
    
    ${downloads_folder}=    Evaluate    __import__('os').path.join(__import__('os').getcwd(), 'Data', 'Files', 'Downloads')
    ${selenium_lib}=    Get Library Instance    SeleniumLibrary
    ${driver}=    Set Variable    ${selenium_lib.driver}
    ${params}=    Create Dictionary    behavior=allow    downloadPath=${downloads_folder}
    Call Method    ${driver}    execute_cdp_cmd    Page.setDownloadBehavior    ${params}