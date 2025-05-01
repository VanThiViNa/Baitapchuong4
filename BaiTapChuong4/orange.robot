*** Settings ***
Documentation    Viết test case cho login
Library           SeleniumLibrary  

*** Variables ***
${URL}                   https://opensource-demo.orangehrmlive.com/web/index.php/auth/login
${USERNAME}              Admin
${PASSWORD}              admin123
${INVALID_USERNAME}      AdminAdmin
${INVALID_PASSWORD}      admin456

*** Test Cases ***
Valid Login
    [Documentation]    Đăng nhập với tài khoản hợp lệ
    Mở trình duyệt
    Đăng nhập    ${USERNAME}    ${PASSWORD}
    Kiểm tra đăng nhập thành công
    Close Browser

Invalid Login
    [Documentation]    Đăng nhập với tài khoản không hợp lệ
    Mở trình duyệt
    Đăng nhập    ${INVALID_USERNAME}    ${INVALID_PASSWORD}
    Kiểm tra đăng nhập thất bại
    Close Browser

*** Keywords ***
Mở trình duyệt
    Open Browser    ${URL}    chrome
    Maximize Browser Window

Đăng nhập
    [Arguments]    ${USERNAME}    ${PASSWORD}
    Wait Until Element Is Visible    css=input[name="username"]    10s
    Input Text    css=input[name="username"]    ${USERNAME}
    Input Text    css=input[name="password"]    ${PASSWORD}
    Click Button    xpath=//button[@type='submit']
    Sleep    2s

Kiểm tra đăng nhập thành công
    Page Should Contain Element    xpath=//p[@class='oxd-userdropdown-name']

Kiểm tra đăng nhập thất bại
    Page Should Contain    Invalid credentials
