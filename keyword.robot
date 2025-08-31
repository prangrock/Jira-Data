*** Settings ***
# Library    SeleniumLibrary
Library    Browser
# Library    libs/zoomout.py
Library    Collections
Library    handledata.py
Library    OperatingSystem
Library    String
Resource    variable.robot
Resource     play.robot

*** Keywords ***
Wait and Click
    [Arguments]    ${path}    ${time}=5s    
    Wait Until Element Is Visible    ${path}    ${time}
    Sleep    0.5s
    Click Element    ${path}
    Sleep    0.5s

Wait Click And Input
    [Arguments]    ${path}    ${text}    ${time}=5s
    Wait Until Element Is Visible    ${path}    ${time}
    Sleep    0.5s
    Click Element    ${path}
    Sleep    2s
    Clear Element Text    ${path}
    Input Text    ${path}    ${text}
    Sleep    0.5s

Wait and Input
    [Arguments]    ${path}    ${text}    ${time}=5s    
    Wait Until Element Is Visible    ${path}    ${time}
    Sleep    0.5s
    Clear Element Text    ${path}
    Input Text    ${path}    ${text}
    Sleep    0.5s

Wait Scroll and Click
    [Arguments]    ${path}    ${time}=5s    ${time2}=0.2s
    Wait Until Element Is Visible    ${path}    ${time}
    Sleep    ${time2}
    Scroll To Element    ${path}
    Sleep    ${time2}
    Click Element    ${path}
    Sleep    ${time2}

Wait Scroll and Input
    [Arguments]    ${path}    ${text}    ${time}=5s    ${time2}=0.2s
    Wait Until Element Is Visible    ${path}    ${time}
    Sleep    ${time2}
    Scroll To Element    ${path}
    Sleep    ${time2}
    Clear Element Text    ${path}
    Input Text    ${path}    ${text}
    Sleep    ${time2}

Get All Path
    ${paths}=   getpathsectionbyrow    ${excelname}    ${pathsheet}
    Set Suite Variable    ${paths}

Get All Data
    ${data}=    Getdatabycol    ${excelname}    ${CAsheet}
    Set Suite Variable    ${data}

Write data to Excel
    [Arguments]    ${data}    ${outputname}
    Log    ${data}
    Datatoexcel    ${data}    ${outputname}

Write Status To Excel
    [Arguments]    ${col1}    ${col2}    ${index}
    ${index}=    Evaluate    ${index}+2
    # Write Status To Excel    Fail    ${index}
    Write To Excel    ${excelname}    ${statussheet}    A${index}    ${col1}
    Write To Excel    ${excelname}    ${statussheet}    B${index}    ${col2}

