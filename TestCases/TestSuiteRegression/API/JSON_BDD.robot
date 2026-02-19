*** Settings ***
Documentation    This test case is related to JSON Comparison Test Plan JIRA-00000
Resource         ../../../Resources/Keywords/kws_json_compare.resource
Resource         ../../../Resources/Keywords/kws_json_tests.resource

*** Test Cases ***
Compare Two Identical JSON Files Successfully
    [Documentation]    Compare two JSON files with identical content and validate they match completely.
    [Tags]  JIRA_TEST:JIRA-XXXXX

    Given JSON files are ready for comparison
    When comparing JSON files for full equality
    Then the JSON files should be identical

Compare JSON Files With Different Values and Fail
    [Documentation]    Compare two JSON files with different values and validate the comparison fails.
    [Tags]  JIRA_TEST:JIRA-XXXXX

    Given JSON files with different content are ready
    When comparing JSON files for full equality with different data
    Then the comparison should fail with mismatch error

Compare JSON Files For Specific Key Fields Only
    [Documentation]    Compare only specific fields between two JSON files.
    [Tags]  JIRA_TEST:JIRA-XXXXX

    Given JSON files are ready for comparison
    When comparing only specific fields between JSON files
    Then the specific fields should match

Validate JSON Structure Contains Required Keys
    [Documentation]    Validate that JSON files contain all required keys.
    [Tags]  JIRA_TEST:JIRA-XXXXX

    Given JSON file is ready for validation
    When validating JSON structure
    Then all required keys should be present

Validate Specific Field Values In JSON
    [Documentation]    Validate that specific fields in JSON have expected values.
    [Tags]  JIRA_TEST:JIRA-XXXXX

    Given JSON file is ready for validation
    When validating specific field values
    Then the field values should match expectations