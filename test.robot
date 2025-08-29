*** Settings ***
Library    SeleniumLibrary
Resource    Variable.robot
Suite Setup       Open Edge With Saved Profile    ${jirapath}
Suite Teardown    Close All Browsers

*** Variables ***
# ====== ปรับค่าให้ตรงเครื่องคุณ ======
${TARGET_URL}       https://portal.office.com/     # หรือ URL ที่คุณต้องการเข้า
${USER_DATA_DIR}    C:/Users/t001397/AppData/Local/Microsoft/Edge/User Data
${PROFILE}          Default                        # หรือ "Profile 1", "Profile 2", ...

*** Keywords ***
Open Edge With Saved Profile
    [Arguments]    ${url}
    ${opt}=    Evaluate    sys.modules['selenium.webdriver'].EdgeOptions()    sys, selenium.webdriver
    Call Method    ${opt}    add_argument    --user-data-dir\=${USER_DATA_DIR}
    Call Method    ${opt}    add_argument    --profile-directory\=${PROFILE}
    
    # เปิดเบราว์เซอร์ด้วย options ที่ตั้งไว้
    Open Browser   ${url}    edge    options=${opt}
    Maximize Browser Window

*** Test Cases ***
Should Reuse Existing Edge Session
    # ตรวจว่าหน้าหลังจากเปิดแล้วมีคำว่า "Office"
    # (คุณควรเปลี่ยนเป็น element หรือข้อความที่บ่งบอกว่าเข้าได้จริง เช่น โลโก้/ชื่อระบบของคุณ)
    Wait Until Page Contains    //div[@role ="search"]//input    15s