*** Settings ***
Library         Collections
Library         OperatingSystem
Library         String
Library         ../../Libraries/jwt_automation.py
Resource        kws_highlevel.resource
Variables       ../../Resources/Variables/CommonVariables.py

*** Keywords ***

the user is on the "${PAGE}" page
    [Documentation]    Navigates to the specified page and automatically handles prompts if detected.

    ${current_url}=    Get Location
    ${url_validation}=    Run Keyword And Ignore Error    Should Be Equal As Strings    ${current_url}    ${URL}/${PAGE}
    
    Run Keyword If    '${url_validation}[0]' == 'FAIL'    Handle Url Validation Failure    ${current_url}

    ${page_capitalized}=    Evaluate    "${PAGE}".capitalize()
    ${page_title_header}=    Replace String Using Regexp    ${page_title_header}    {PARAMETER}    File ${page_capitalized}er
    Page Should Contain Element    ${page_title_header}

Handle Url Validation Failure
    [Arguments]    ${current_url}
    [Documentation]    Handles URL mismatch by checking if JWT is present.

    ${has_jwt}=    Run Keyword And Return Status    Should Contain    ${current_url}    Authorization=
    Run Keyword If    ${has_jwt}
    ...    show encrypted message hint
    ...    ELSE
    ...    Fail    Expected to be on ${URL}/${PAGE} but was on ${current_url}

show encrypted message hint
    [Documentation]    Shows a hint about the encrypted message in the CSV without revealing the solution.

    Sleep    2s    Give user time to read the page
    
    Log    🔐 Something is different with this URL... There's a secret hidden in the next step. Can you figure out how to unlock it?    WARN
    Execute Javascript    window.alert("🔐 Something is different with this URL...!\\n\\nThere's a secret message hidden bellow!\\n\\nIt's encrypted and locked. Can you find the key to decrypt it?");
        
should validate "${MESSAGE}"
    [Documentation]    Validates if the message "${MESSAGE}" is present on the page, highlights it if found, and takes a screenshot in local environment. Logs a message if not found.

    ${result}=    Run Keyword And Ignore Error    Wait Until Page Contains    ${MESSAGE}    timeout=${COMMON_TIMEOUT}
    Run Keyword If    '${result}[0]' == 'PASS'    Highlight Element By Text    ${MESSAGE}
    Run Keyword If    '${result}[0]' == 'PASS' and '${environmentToRunTest}'=='LOCAL'    Take Screenshots Browser    # Only take screenshots in local environment, to avoid filling up the storage with screenshots when running in CI.
    Run Keyword If    '${result}[0]' == 'FAIL'    Fail    The message ${MESSAGE} was not found.