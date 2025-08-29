*** Settings ***
Library    SeleniumLibrary
Library    libs/zoomout.py
Library    Collections
Library    handledata.py
Library    OperatingSystem
Library    String
Resource    variable.robot

*** Keywords ***
PAGE ZOOM to 50
    zoom_out
    sleep    0.5s

Open XLeads
    Open Browser    ${jirapath}    browser=firefox
    Maximize Browser Window
    PAGE ZOOM to 50
    Sleep    0.5s
    
Log in
    Open XLeads
    Input Text    //*[@id="txtUserID"]    ${Username}
    Input Text    //*[@id="txtPassword"]    ${Password}
    Sleep    0.5s
    Click Element    //button[@id="sub"]
    Sleep    0.5s

Wait and Click
    [Arguments]    ${path}    ${time}=5s    
    Wait Until Element Is Visible    ${path}    ${time}
    Sleep    0.5s
    Click Element    ${path}
    Sleep    0.5s

Wait and Select Drop Down
    [Arguments]    ${path}    ${role}    ${time}=5s
    Wait Until Element Is Visible    ${path}    ${time}
    Sleep    0.5s
    Select From List By Label    ${path}    ${role}
    Sleep    0.5s

Wait and Input
    [Arguments]    ${path}    ${text}    ${time}=5s    
    Wait Until Element Is Visible    ${path}    ${time}
    Sleep    0.5s
    Clear Element Text    ${path}
    Input Text    ${path}    ${text}
    Sleep    0.5s

Get All Path
    ${paths}=   getpathsectionbyrow    ${excelname}    ${pathsheet}
    Set Suite Variable    ${paths}

Get All Data
    ${ca_status}=    Getdatabycol    ${excelname}    ${CAsheet}
    Set Suite Variable    ${ca_status}

Select New Window
    [Arguments]    @{oldwindow}
    ${newwindow}=    Get Window Handles
    FOR    ${i}    IN    @{newwindow}
        Run Keyword If    '${i}' not in @{oldwindow}    Switch Window    locator=${i}
    END
    Maximize Browser Window
    ${title}=    Get Title
    Log To Console    ${title}

Get Data From Table
    [Arguments]    ${path}    ${sheetname}    ${Key}
    ${pathpart}=    Split String    ${path}    [split]
    ${nlist}    Get Length    ${pathpart}
    ${tablepath}=    Get From List    ${pathpart}    0
    IF    ${mrow} == None
        ${tr}    Get WebElements    ${tablepath}   
        ${mrow}    Get Length    ${tr}
    END
    FOR    ${i}    IN RANGE    2    ${mrow}+1
        IF    ${mrow} == 2
            ${data}=    Set Variable    No Item
            ${No}=    Evaluate    ${i}-1
            ${temp_result}=    Create Dictionary    section=${sheetname}    Keys=${Key}.ลำดับที่${No}    Value=${data}
            Append To List    ${result}    ${temp_result}
            RETURN
        ELSE
            ${stri}=    Convert To String    [${i}]
            ${path}=    Set Variable    ${pathpart}[0]${stri}${pathpart}[1]
            IF    ${nlist} == 3
                ${path}=    Set Variable    ${pathpart}[0]${stri}${pathpart}[1]${stri}${pathpart}[2]
            END
            ${data}=    Get Data From Text Or Input    ${path}
            ${No}=    Evaluate    ${i}-1
            ${temp_result}=    Create Dictionary    section=${sheetname}    Keys=${Key}.ลำดับที่${No}    Value=${data}
            Append To List    ${result}    ${temp_result}
        END
    END

Get Data From Text Or Input
    [Arguments]    ${path}
    ${Isinput}=    Run Keyword And Return Status    Should Contain    ${path}    //input
    IF    ${Isinput}
        ${data}=    Get Element Attribute    ${path}    value
        IF    '${data}' == 'true'
            ${data}    Set Variable    False
        ELSE IF    '${data}' == 'false'
            ${data}    Set Variable    True
        END
    ELSE
        ${data}=    Get Text    ${path}
    END
    RETURN    ${data}

Get Data From 3element
    [Arguments]    ${indexrow}    ${Keys}    ${section}    ${data}
    ${nexti}=    Evaluate    ${indexrow}+1
    ${skipindex}=    Evaluate    ${indexrow}+2
    ${prekey}=    Get From List    ${Keys}    ${nexti}
    ${nextkey}=    Get From List    ${Keys}    ${skipindex}
    ${predata}=    Get Data From Text Or Input    ${section}[${prekey}]
    ${nextdata}=    Get Data From Text Or Input    ${section}[${nextkey}]
    ${data}=    Set Variable    ${data} ${predata} ${nextdata}
    ${str_Keys}=    Convert To String    ${prekey}
    RETURN    ${data}

Write data to Excel
    [Arguments]    ${data}    ${outputname}
    Log    ${data}
    Datatoexcel    ${data}    ${outputname}

Write Status To Excel
    [Arguments]    ${text}    ${index}
    ${index}=    Evaluate    ${index}+2
    Write To Excel    ${excelname}    ${CAsheet}    B${index}    ${text}

