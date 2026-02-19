*** Settings ***
Documentation    JSON comparison and validation keywords
Library         Collections
Library         OperatingSystem
Library         String
Variables       ../../Resources/Variables/CommonVariables.py

*** Keywords ***
Read Json File
    [Documentation]    Reads a JSON file and returns its content as a dictionary.
    [Arguments]    ${file_path}

    ${file_content}=    Get File    ${file_path}
    ${json_data}=    Evaluate    json.loads("""${file_content}""")    json
    RETURN    ${json_data}

Json Files Should Be Identical
    [Documentation]    Compares two JSON files and validates they are identical.
    [Arguments]    ${file_path_1}    ${file_path_2}

    ${json_1}=    Read Json File    ${file_path_1}
    ${json_2}=    Read Json File    ${file_path_2}
    
    ${json_1_str}=    Evaluate    json.dumps(${json_1})    json
    ${json_2_str}=    Evaluate    json.dumps(${json_2})    json
    
    Should Be Equal As Strings    ${json_1_str}    ${json_2_str}    msg=JSON files do not match
    Log    ✓ JSON files are identical    INFO

Json Files Should Have The Same Keys
    [Documentation]    Compares two JSON files and validates they have the same keys.
    [Arguments]    ${file_path_1}    ${file_path_2}

    ${json_1}=    Read Json File    ${file_path_1}
    ${json_2}=    Read Json File    ${file_path_2}
    
    ${keys_1}=    Get Dictionary Keys    ${json_1}
    ${keys_2}=    Get Dictionary Keys    ${json_2}
    
    ${keys_1_str}=    Evaluate    str(sorted(${keys_1}))
    ${keys_2_str}=    Evaluate    str(sorted(${keys_2}))
    
    Should Be Equal As Strings    ${keys_1_str}    ${keys_2_str}    msg=JSON files have different keys
    Log    ✓ JSON files have the same keys    INFO

Json Field Values Should Match
    [Documentation]    Compares specific field values between two JSON files.
    [Arguments]    ${file_path_1}    ${file_path_2}    @{field_names}

    ${json_1}=    Read Json File    ${file_path_1}
    ${json_2}=    Read Json File    ${file_path_2}
    
    FOR    ${field}    IN    @{field_names}
        ${value_1}=    Get From Dictionary    ${json_1}    ${field}
        ${value_2}=    Get From Dictionary    ${json_2}    ${field}
        
        Should Be Equal    ${value_1}    ${value_2}    msg=Field '${field}' does not match
        Log    ✓ Field '${field}' matches: ${value_1}    INFO
    END

Json Should Contain Key
    [Documentation]    Validates that a JSON file contains a specific key.
    [Arguments]    ${file_path}    ${key}

    ${json_data}=    Read Json File    ${file_path}
    Dictionary Should Contain Key    ${json_data}    ${key}
    Log    ✓ JSON contains key '${key}'    INFO

Json Field Value Should Be
    [Documentation]    Validates that a specific field in JSON has the expected value.
    [Arguments]    ${file_path}    ${field}    ${expected_value}

    ${json_data}=    Read Json File    ${file_path}
    ${actual_value}=    Get From Dictionary    ${json_data}    ${field}
    
    Should Be Equal    ${actual_value}    ${expected_value}    msg=Field '${field}' value mismatch
    Log    ✓ Field '${field}' has expected value: ${expected_value}    INFO

