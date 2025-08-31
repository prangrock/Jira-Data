*** Settings ***
Library    Browser
Library    BuiltIn
Library    OperatingSystem
Resource    Variable.robot

*** Keywords ***

Open Browsers With Same Profile
    [Arguments]    ${url}    ${browser}
    ${profiledir}=    Normalize Path    ${CURDIR}/browser-state
    Create Directory    ${profiledir}
    New Persistent Context    ${profiledir}    browser=chromium    channel=${browser}    headless=${False}    viewport=${None}
    New Page    ${url}
    # Maximize Browser Window

# Open Browsers With Same Profile
#     [Arguments]    ${url}    ${browser}    ${profiledir}=./browser-state
#     New Persistent Context    ${profiledir}    browser=chromium    channel=${browser}    headless=${False}    viewport={"width":1280,"height":800} 
#     New Page    ${url}

Maximize Browser Window
    Set Viewport Size    1920    1080

Click Element
    [Arguments]    ${locator}    ${timeout}=1000s
    Wait For Elements State    ${locator}    visible    ${timeout}
    Wait For Elements State    ${locator}    stable     ${timeout}
    Click    ${locator}

Click And Type
    [Arguments]    ${field_locator}    ${text}    ${timeout}=10s
    Sleep    0.5s
    Wait Until Element Is Visible    ${field_locator}    ${timeout}
    Click Element    ${field_locator}
    Press Keys    Backspace
    Type Text    //form[@role="presentation"]//input[@role="combobox"]   ${text}
    Sleep    1s
    # Pick From Atlaskit Picker (by text)    ${text}
    Press Keys    //form[@role="presentation"]//input[@role="combobox"]    Enter
    Sleep    0.5s  

Click And Type Date
    [Arguments]    ${field_locator}    ${text}    ${timeout}=10s
    Sleep    0.5s
    Wait Until Element Is Visible    ${field_locator}    ${timeout}
    Click Element    ${field_locator}
    Press Keys    Backspace
    Type Text    //form[@role="presentation"]//input[@role="combobox"]   ${text}
    Sleep    1s
    # Pick From Atlaskit Picker (by text)    ${text}
    Press Keys    //form[@role="presentation"]//input[@role="combobox"]    Enter
    Press Keys    //form[@role="presentation"]//input[@role="combobox"]    Enter
    Sleep    0.5s  

Input Text
    [Arguments]    ${locator}    ${text}    ${timeout}=1000s
    Wait For Elements State    ${locator}    visible    ${timeout}
    Click                  ${locator}
    Clear Text             ${locator}
    Type Text              ${locator}    ${text}    delay=0.0s
    ${val}=    Get Property    ${locator}    value
    Should Be Equal    ${val}    ${text}

Clear Element Text
    [Arguments]    ${locator}    ${timeout}=1000s
    Wait For Elements State    ${locator}    visible    ${timeout}
    Clear Text    ${locator}

Wait Until Element Is Visible
    [Arguments]    ${locator}    ${timeout}=1000s
    Wait For Elements State    ${locator}    visible    ${timeout}

Element Should Be Visible
    [Arguments]    ${locator}    ${timeout}=5s
    Wait For Elements State    ${locator}    visible    ${timeout}

Element Should Contain
    [Arguments]    ${locator}    ${text}    ${timeout}=1000s
    Wait For Elements State    ${locator}    visible    ${timeout}
    ${content}=    Get Text    ${locator}
    Should Contain    ${content}    ${text}
