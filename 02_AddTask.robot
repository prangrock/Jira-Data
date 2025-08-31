*** Settings ***
# Library    SeleniumLibrary
Library    handledata.py
Resource    Variable.robot
Resource    keyword.robot
Resource     play.robot
Suite Setup    Log in

*** Keywords ***
Log in
    Open Browsers With Same Profile    ${jirapath}    ${browser}
    Sleep    3s
    ${Islogined}=    Run Keyword And Return Status    Element Should Be Visible    ${home_section}[log_microsoft]
    IF    ${Islogined}
        Wait and Click    ${home_section}[log_microsoft]
        Sleep    3s
        ${IsAnother}=    Run Keyword And Return Status    Element Should Be Visible    //div[@id="otherTileText"]
        IF    ${IsAnother}
            Wait and Click    //div[@id="otherTileText"]
        END
        Wait and Input    ${home_section}[username]    ${Username}
        # Wait and Click   ${home_section}[next]
        Sleep    3s
        Wait and Click    //*[@id="idSIButton9"]    300s
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
    # Wait and Input    ${home_section}[search]    ${Qa}
    # Press Keys    ${home_section}[search]    ENTER
    Wait Until Element Is Visible    ${home_section}[search]    timeout=300s
    ${Keys_Nos}=    Getkeysbyorder    ${data}
    FOR    ${index}    ${Keys_No}    IN ENUMERATE    @{Keys_Nos}
        TRY
            # Wait and Input    //input[@data-test-id="search-dialog-input"]    ${Qa}
            # Press Keys    ${home_section}[search]    ENTER
            ${taskname}=    Set Variable    ${data}[${Keys_No}][TaskName]
            ${pathtask}    Set Variable    //*[text()="${taskname}"]
            Wait Scroll and Click    ${pathtask}
            Wait Scroll and Click    ${home_section}[addsubtask]
            Wait Scroll and Input    ${home_section}[namesubtask]    ${data}[${Keys_No}][SubTaskName]
            Wait and Click    ${home_section}[create]
            ${pathtask}    Set Variable    //*[text()="${data}[${Keys_No}][SubTaskName]"]
            Wait Scroll and Click    ${pathtask}
            Click And Type    ${home_section}[Assignee]    ${data}[${Keys_No}][Assignee]
            # Wait Click And Input    ${home_section}[Reporter]    ${data}[${Keys_No}][Reporter]
            Click And Type Date    (//span[@class="_1reo15vq _18m915vq _syaz131l _1bto1l2s _p12f1osq"])[3]    ${data}[${Keys_No}][StartDate]
            # Click And Type    ${home_section}[EndDate]    ${data}[${Keys_No}][EndDate]
            # Click And Type    ${home_section}[ActualStartDate]    ${data}[${Keys_No}][ActualStartDate]
            # Click And Type   ${home_section}[ActualEndDate]    ${data}[${Keys_No}][ActualEndDate]
            # Wait Click And Input    ${home_section}[OriginalEstimate]    ${data}[${Keys_No}][OriginalEstimate]
            # Wait Scroll and Click    ${home_section}[TimeTracking]
            # Wait Scroll and Input    ${home_section}[TimeSpent]    ${data}[${Keys_No}][TimeSpent]
            # Wait Click And Input    ${home_section}[starttime]    ${data}[${Keys_No}][starttime]
            # Press Keys      ${home_section}[starttime]      ENTER
            # Wait and Click    ${home_section}[save]
            # Wait Click And Input    ${home_section}[Addcomment]    ${data}[${Keys_No}][Addcomment]
            # Wait and Click    ${home_section}[savecomment]
            # Wait Click And Input    ${home_section}[Description]    ${data}[${Keys_No}][Description]
            # Wait and Click    ${home_section}[savedescription]
            Write Status To Excel    ${data}[${Keys_No}][SubTaskName]   Complete    ${index}
        EXCEPT
            # Switch Window    ${window}[0]
            Log To Console    Global Search Fail CA : ${Keys_No}
            Write Status To Excel    ${data}[${Keys_No}][SubTaskName]   Fail    ${index}
        END 
    END
    Close Context