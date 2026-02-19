*** Settings ***
Documentation    JSON comparison and validation keywords
Library         Collections
Library         OperatingSystem
Library         String
Resource        kws_json_compare.resource

*** Variables ***
${JSON_FIRST}       ${EXECDIR}/Data/Files/json/first.json
${JSON_SECOND}      ${EXECDIR}/Data/Files/json/second.json
${JSON_THIRD}       ${EXECDIR}/Data/Files/json/third.json

*** Keywords ***
JSON files are ready for comparison
    [Documentation]    Setup: Load the JSON files for comparison.

    Log    Loading JSON files: first.json and second.json for comparison    INFO

JSON files with different content are ready
    [Documentation]    Setup: Load JSON files with different content.

    Log    Loading JSON files: first.json and third.json (different content)    INFO

comparing JSON files for full equality
    [Documentation]    Compare two identical JSON files completely.

    Json Files Should Be Identical    ${JSON_FIRST}    ${JSON_SECOND}

comparing JSON files for full equality with different data
    [Documentation]    Compare two JSON files with different data.

    Run Keyword And Expect Error    *    Json Files Should Be Identical    ${JSON_FIRST}    ${JSON_THIRD}

comparing only specific fields between JSON files
    [Documentation]    Compare only specific fields: status, user_id, and account_number.

    Json Field Values Should Match    ${JSON_FIRST}    ${JSON_SECOND}    status    user_id    account_number

validating JSON structure
    [Documentation]    Validate JSON file structure contains required keys.

    Json Should Contain Key    ${JSON_FIRST}    status
    Json Should Contain Key    ${JSON_FIRST}    user_id
    Json Should Contain Key    ${JSON_FIRST}    account_number
    Json Should Contain Key    ${JSON_FIRST}    transactions
    Json Should Contain Key    ${JSON_FIRST}    balance
    Json Should Contain Key    ${JSON_FIRST}    currency

validating specific field values
    [Documentation]    Validate specific field values in JSON.

    Json Field Value Should Be    ${JSON_FIRST}    status    success
    ${expected_user_id}=    Convert To Integer    12345
    Json Field Value Should Be    ${JSON_FIRST}    user_id    ${expected_user_id}
    Json Field Value Should Be    ${JSON_FIRST}    currency    EUR

JSON file is ready for validation
    [Documentation]    Setup: Load a JSON file.

    Log    Loading JSON file: first.json for validation    INFO

the JSON files should be identical
    [Documentation]    Assert: Validate that JSON files are identical.

    Log    ✓ JSON files comparison passed    INFO

the comparison should fail with mismatch error
    [Documentation]    Assert: Validate that comparison failed as expected.

    Log    ✓ JSON comparison correctly identified differences    INFO

all required keys should be present
    [Documentation]    Assert: All required keys are present in JSON.

    Log    ✓ All required keys are present in the JSON file    INFO

the field values should match expectations
    [Documentation]    Assert: All field values match expectations.

    Log    ✓ All field values match their expected values    INFO

the specific fields should match
    [Documentation]    Assert: Specific fields match between JSON files.

    Log    ✓ Specific field values match between JSON files    INFO
