*** Settings ***
Library         OperatingSystem
Resource        kws_highlevel.resource
Resource        kws_common.resource
Variables        ../Locators/PageObjectElements/UploadElements.py

*** Variables ***
${PATH}                         ${EXECDIR}/Data/Files/

*** Keywords ***

the user uploads the file "${FILE_NAME}"
    [Documentation]    Uploads the specified file using the "Choose File" button.

    Choose File    ${upload_button}    ${PATH}${FILE_NAME}
    Click   ${upload_submit_button}

the user uploads the file "${FILE_NAME}" using drag and drop
    [Documentation]    Uploads the specified file using drag and drop.
    ...    This keyword simulates a drag and drop file upload by making the hidden input visible temporarily,
    ...    selecting the file, triggering the change event, and then submitting the form.

    ${file_path}=    Normalize Path    ${PATH}${FILE_NAME}
    Simulate Drag And Drop File Upload    ${file_path}    ${drag_and_drop_area}
    Click   ${upload_submit_button}

the user clicks the upload submit button without choosing a file
    [Documentation]    Clicks the upload submit button without selecting a file to trigger validation.
    Click   ${upload_submit_button}

the user clicks on the drag and drop area without dropping a file and then clicks the upload submit button
    [Documentation]    Clicks on the drag and drop area to focus it, then clicks the upload submit button without dropping a file to trigger validation.
    Click   ${drag_and_drop_area}
    Click   ${upload_submit_button}