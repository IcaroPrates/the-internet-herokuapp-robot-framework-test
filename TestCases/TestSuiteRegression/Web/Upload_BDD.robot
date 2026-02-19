*** Settings ***
Documentation    This test case is related to Upload File Test Plan JIRA-00000
Resource          ../../../Resources/Keywords/kws_highlevel.resource
Resource          ../../../Resources/Keywords/kws_lowlevel.resource
Resource          ../../../Resources/Keywords/kws_common.resource
Resource          ../../../Resources/Keywords/kws_upload.resource

Test Setup    Open Application   ${URL}/upload
Test Teardown    Close Browser

*** Test Cases ***

Upload Using Choose File Successfully

    [Documentation]    Upload file on the application successfully
    [Tags]  JIRA_TEST:JIRA-XXXXX

    Given the user is on the "upload" page
    When the user uploads the file "message_for_test.csv"
    Then should validate "File Uploaded!"
    And should validate "message_for_test.csv"

Upload Using Drag And Drop Successfully
    [Documentation]    Upload file on the application using drag and drop successfully
    [Tags]  JIRA_TEST:JIRA-XXXXX

    Given the user is on the "upload" page
    When the user uploads the file "message_for_test.csv" using drag and drop
    Then should validate "message_for_test.csv"

Try Use Upload Submit Button Without Choosing File and Fail
    [Documentation]    Try to submit the upload form without choosing a file, and validate that the appropriate error message is displayed.
    [Tags]  JIRA_TEST:JIRA-XXXXX

    Given the user is on the "upload" page
    When the user clicks the upload submit button without choosing a file
    Then should validate "Internal Server Error"

Try Use Upload Submit After Click in Drag And Drop Area Without Dropping File and Fail
    [Documentation]    Click on the drag and drop area to focus it, then click the upload submit button without dropping a file, and validate that the appropriate error message is displayed.
    [Tags]  JIRA_TEST:JIRA-XXXXX

    Given the user is on the "upload" page
    When the user clicks on the drag and drop area without dropping a file and then clicks the upload submit button
    Then should validate "Internal Server Error"

Upload With Little Bonus
    [Documentation]    Bonus test: opens the upload page with something different inthe URL
    [Tags]  JIRA_TEST:JIRA-XXXXX
    [Setup]    Open Application With Jwt    ${URL}/upload    ${EXECDIR}/Data/Files/message_for_test.csv

    Given the user is on the "upload" page
    When the user uploads the file "message_for_test.csv"
    Then Oops!
