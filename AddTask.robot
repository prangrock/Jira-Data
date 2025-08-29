*** Settings ***
Library    SeleniumLibrary
Library    handledata.py
Resource    Variable.robot
Resource    keyword.robot

*** Keywords ***
Log in
    Open XLeads
    ${Islogined}=    Run Keyword And Return Status    Element Should Be Visible    ${home_section}[logined]
    IF    ${Islogined}
        Wait and Click    ${home_section}[log_microsoft]
        Wait and Input    ${home_section}[username]    ${Username}
        Wait and Click   ${home_section}[next]
        Sleep    0.5s
        Wait Until Element Is Visible    ${home_section}[search]    timeout=300s
        Sleep    0.5s
    ELSE
        RETURN 
    END

# Get Text Each Tab
#     [Arguments]    ${strtab}
#     Wait and Click    ${tab_section}[${strtab}]
#     ${sheetname}    Set Variable    ${strtab}
#     ${section}=    Get From Dictionary    ${paths}    ${sheetname}
#     ${Keys}=    Getkeysbyorder    ${section}
#     ${skipindex}=    Set Variable    -1
#     ${mrow}=    Set Variable    None
#     Set Global Variable    ${mrow}
#     FOR    ${indexrow}    ${Key}    IN ENUMERATE    @{Keys}
#         Continue For Loop If    ${indexrow} <= ${skipindex}
#         ${str_Keys}=    Convert To String    ${Key}
#         log    ${section}[${str_Keys}]
#         ${status}=    Run Keyword And Return Status   Page Should Contain Element   ${section}[${str_Keys}]
#         ${Istable}=    Run Keyword And Return Status    Should Start With    ${section}[${str_Keys}]    //table
#         Log    ${status}
#         IF    ${status}
#             ${data}=    Get Data From Text Or Input    ${section}[${str_Keys}]
#             ${Is3element}=    Run Keyword And Return Status    Should End With    ${Key}    3element
#             IF    ${Is3element}
#                 ${data}=    Get Data From 3element    ${indexrow}    ${Keys}    ${section}    ${data}
#             END
#             Log    ${str_Keys} : ${data}
#         ELSE IF    ${Istable}
#             Get Data From Table    ${section}[${str_Keys}]    ${sheetname}    ${Key}
#             CONTINUE
#         ELSE
#             ${data}=    Set Variable    No Path Exist
#             Log    ${str_Keys} : ${data}
#         END
#         ${temp_result}=    Create Dictionary    section=${sheetname}    Keys=${Key}    Value=${data}
#         Append To List    ${result}    ${temp_result}
#         Log    ${result}
#     END

*** Test Cases ***
GlobalSearch
    Get All Path
    Get All Data
    ${home_section}=    Get From Dictionary    ${paths}    Home
    Set Suite Variable    ${home_section}
    Log in
    Wait and Input    ${home_section}[search]    ${Qa}
    Press Keys    ${home_section}[search]    ENTER
    ${Keys_No}=    Getkeysbyorder    ${data}
    FOR    ${index}    ${Keys_No}    IN ENUMERATE    @{Keys_No}
        TRY
            ${result}=    Create List
            Set Global Variable    ${result}
            ${pathtask}    Set Variable    //*[text()="${data}[${Keys_No}][TaskName]"]
            Wait Scroll and Click    ${pathtask}
            Wait Scroll and Click    ${home_section}[addsubtask]
            Wait Scroll and Input    ${home_section}[namesubtask]    ${data}[${Keys_No}][SubTaskName]
            Wait and Click    ${home_section}[create]
            # 
            Wait and Click    ${home_section}[search]
            ${str_CA}=    Convert To String    ${Key_CA}
            Set Suite Variable    ${str_CA}
            Log To Console    Run CA : ${str_CA}
            ${window}=    Get Window Handles
            Select Frame    ${home_section}[searchframe]
            Wait and Input    ${home_section}[NoCA]    ${id}[${str_CA}][CA]
            Wait and Click    ${home_section}[searchbutton]
            Wait and Click    ${home_section}[Inquiry]
            Unselect Frame
            Select Frame    ${home_section}[frameca]
            Wait and Click    ${home_section}[detailth]
            Unselect Frame
            ${window}=    Get Window Handles
            Switch Window    ${window}[1]
            Sleep    2s
            ${filename}=    Set Variable    Output_${str_CA}.xlsx
            ${count}=    Get Length    ${result}
            Log To Console    Total Xpath : ${count} CA : ${str_CA}
            Write data to Excel    ${result}    ${filename}
            Write Status To Excel    Complete    ${index}
            Close Window
            Switch Window    ${window}[0]
            Wait and Click    ${home_section}[close]
        EXCEPT
            Switch Window    ${window}[0]
            Log To Console    Global Search Fail CA : ${str_CA}
            Write Status To Excel    Fail    ${index}
            Close Window
        END 
    END
    Close Window