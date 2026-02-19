*** Settings ***
Documentation     This test case is related to File Download Test Plan JIRA-00000
Resource          ../../../Resources/Keywords/kws_highlevel.resource
Resource          ../../../Resources/Keywords/kws_download.resource
Resource          ../../../Resources/Keywords/kws_common.resource

Test Setup    Open Application    ${URL}/download
Test Teardown    Close Browser

*** Test Cases ***

Download File Successfully
    [Documentation]    Download a file from the application successfully and validate that it exists and is not empty.
    ...   If the file already exists, it will be cleaned up before downloading to ensure a fresh download and accurate validation.
    [Tags]  JIRA_TEST:JIRA-XXXXX

    Given the user is on the "download" page
    When the user downloads the file "testfile.txt" and validates it
    Then the downloaded file "testfile.txt" should exist and not be empty

Download some file File and Validate Then Cleanup
    [Documentation]    Download a file, validate it, and then clean up by deleting the downloaded file.
    [Tags]  JIRA_TEST:JIRA-XXXXX

    Given the user is on the "download" page
    When the user downloads the file "some-file.txt" and validates it
    Then the downloaded file "some-file.txt" should exist and not be empty
    And cleanup download file "some-file.txt"

Download Random File Successfully
    [Documentation]    Download a randomly selected file from the available files list.
    ...   The random file is selected, downloaded, validated, and then cleaned up.
    [Tags]  JIRA_TEST:JIRA-XXXXX

    Given the user is on the "download" page
    When the user downloads the file "random" and validates it
    Then the downloaded file "random" should exist and not be empty

Download Zero Bytes File Successfully
    [Documentation]    Download the zero-byte file and validate that it is empty.
    [Tags]  JIRA_TEST:JIRA-XXXXX

    Given the user is on the "download" page
    When the user downloads the file "zero_bytes_file.txt" and validates it
    Then the downloaded file "zero_bytes_file.txt" should be empty
    
Download All no Zero Bytes Files Successfully
    [Documentation]    Download and validate all files from the available files list, excluding zero-byte files.
    ...   Cleans up the download folder before and after the test.
    [Tags]  JIRA_TEST:JIRA-XXXXX

    Given the user is on the "download" page
    When the user downloads all available files and validates them
    Then cleanup all download files
