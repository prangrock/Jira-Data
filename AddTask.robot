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

*** Test Cases ***
GlobalSearch
    Get All Path
    Get All Data
    ${home_section}=    Get From Dictionary    ${paths}    Home
    Set Suite Variable    ${home_section}
    Log in
    # Wait and Input    ${home_section}[search]    ${Qa}
    # Press Keys    ${home_section}[search]    ENTER
    ${Keys_No}=    Getkeysbyorder    ${data}
    FOR    ${index}    ${Keys_No}    IN ENUMERATE    @{Keys_No}
        TRY
            Wait and Input    ${home_section}[search]    ${Qa}
            Press Keys    ${home_section}[search]    ENTER
            ${pathtask}    Set Variable    //*[text()="${data}[${Keys_No}][TaskName]"]
            Wait Scroll and Click    ${pathtask}
            Wait Scroll and Click    ${home_section}[addsubtask]
            Wait Scroll and Input    ${home_section}[namesubtask]    ${data}[${Keys_No}][SubTaskName]
            Wait and Click    ${home_section}[create]
            ${pathtask}    Set Variable    //*[text()="${data}[${Keys_No}][SubTaskName]"]
            Wait Scroll and Click    ${pathtask}
            Wait Scroll and Input    ${home_section}[Assignee]    ${data}[${Keys_No}][Assignee]
            Wait Scroll and Input    ${home_section}[Reporter]    ${data}[${Keys_No}][Reporter]
            Wait Scroll and Click    ${home_section}[StartDate]
            Wait Scroll and Click    ${home_section}[EndDate]
            Wait Scroll and Click    ${home_section}[ActualStartDate]
            Wait Scroll and Click    ${home_section}[ActualEndDate]
            Wait Click And Input    ${home_section}[OriginalEstimate]    ${data}[${Keys_No}][OriginalEstimate]
            Wait Scroll and Click    ${home_section}[TimeTracking]
            Wait Scroll and Input    ${home_section}[TimeSpent]    ${data}[${Keys_No}][TimeSpent]
            Wait Click And Input    ${home_section}[starttime]    ${data}[${Keys_No}][starttime]
            Press Keys      ${home_section}[starttime]      ENTER
            Wait and Click    ${home_section}[save]
            Wait Click And Input    ${home_section}[Addcomment]    ${data}[${Keys_No}][Addcomment]
            Wait and Click    ${home_section}[savecomment]
            Wait Click And Input    ${home_section}[Description]    ${data}[${Keys_No}][Description]
            Wait and Click    ${home_section}[savedescription]
        EXCEPT
            # Switch Window    ${window}[0]
            Log To Console    Global Search Fail CA : ${Keys_No}
            # Write Status To Excel    Fail    ${index}
            # Close Window
        END 
    END
    # Close Window