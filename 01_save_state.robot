*** Settings ***
Library    Collections
Library    handledata.py
Library    OperatingSystem
Library    String
Resource    variable.robot
Resource     play.robot

*** Test Cases ***
Login And Save Session
    Open Browsers With Same Profile    ${jirapath}    ${browser}
    Sleep    10s
    Wait Until Element Is Visible    //div[@role ="search"]//input    timeout=300s
    Close Browser

