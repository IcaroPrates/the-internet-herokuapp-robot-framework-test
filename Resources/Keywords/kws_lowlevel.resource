*** Settings ***
Documentation    Project Low Level Keywords.
Library           SeleniumLibrary
Variables         ../../Resources/Variables/CommonVariables.py

*** Keywords ***

Highlight Element
    [Arguments]    ${locator}
    [Documentation]    Highlights the element identified by ``locator`` with a red border.
    ...
    ...    *Input Arguments:*
    ...    | *Name* | *Description* |
    ...    | locator | xpath of the element to highlight |
    ...
    ...    *Owner:*
    ...    Icaro Prates
    Execute JavaScript    var element = document.evaluate("${locator}", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue; if (element) { element.style.border='3px solid red'; }

Highlight Element By Text
    [Arguments]    ${text}
    [Documentation]    Highlights the element identified by its text with a red border.
    ...
    ...    *Input Arguments:*
    ...    | *Name* | *Description* |
    ...    | text | text of the element to highlight |
    ...    *Owner:*
    ...    Icaro Prates
    ${locator}=    Set Variable    //*[contains(text(),'${text}')]
    Highlight Element    ${locator}
    
Click
    [Arguments]     ${locator}
    [Documentation]    Waits for an element identified by ``locator`` and clicks on it.
    ...
    ...    *Input Arguments:*
    ...    | *Name* | *Description* |
    ...    | locator | xpath of the element to click |    
    ...
    ...    *Owner:*
    ...    Icaro Prates
    Wait   ${locator}
    SeleniumLibrary.Click Element  ${locator}

Take Screenshots Browser
    [Documentation]    Setup for taking Browser screenshots
    ...
    ...    *Owner:*
    ...    Icaro Prates
    Run Keyword and Ignore Error    SeleniumLibrary.CapturePageScreenshot

Wait
    [Arguments]     ${locator}    ${timeout}=${COMMON_TIMEOUT}
    [Documentation]    Waits for an element identified by ``locator``
    ...
    ...    *Input Arguments:*
    ...    | *Name* | *Description* |
    ...    | locator | xpath of the element to wait |
    ...
    ...    *Owner:*
    ...    Icaro Prates
    SeleniumLibrary.Wait Until Page Contains Element    ${locator}  ${timeout}

Simulate Drag And Drop File Upload
    [Arguments]    ${file_path}    ${drop_area_locator}
    [Documentation]    Simulates drag and drop file upload using JavaScript.
    ...    This keyword finds the file input element, makes it temporarily visible and interactable,
    ...    assigns the file to it, and triggers the change event to notify the drag-and-drop area.
    ...
    ...    *Input Arguments:*
    ...    | *Name* | *Description* |
    ...    | file_path | Absolute path to the file to upload |
    ...    | drop_area_locator | Locator of the drop area element |
    ...
    ...    *Owner:*
    ...    Icaro Prates
    
    
    Click    ${drop_area_locator}    # Click the drop area to ensure it's focused before uploading the file.
    ${input_locator}=    Set Variable    css:input[type="file"]
    Execute JavaScript    
    ...    var input = document.querySelector('input[type="file"]');
    ...    if(input) {
    ...        input.style.display = 'block';
    ...        input.style.visibility = 'visible';
    ...        input.style.opacity = '1';
    ...        input.style.position = 'relative';
    ...        input.style.zIndex = '9999';
    ...    }
    
    # Select the file
    Choose File    ${input_locator}    ${file_path}
    
    # Trigger change event and hide the input again
    Execute JavaScript    
    ...    var input = document.querySelector('input[type="file"]');
    ...    if(input) {
    ...        var event = new Event('change', { bubbles: true });
    ...        input.dispatchEvent(event);
    ...        input.style.display = 'none';
    ...        input.style.visibility = 'hidden';
    ...        input.style.opacity = '0';
    ...    }
