@echo off
chcp 65001 >nul
REM ============================================================
REM 创建Windows桌面快捷方式脚本 (批处理版本)
REM ============================================================
REM 使用方法：
REM   1. 直接双击运行此文件（会使用默认配置）
REM   2. 或者编辑此文件，修改下面的变量
REM ============================================================

REM ============ 配置区域 - 请根据需要修改 ============
REM 自动获取脚本所在目录的父目录（项目根目录）
for %%I in ("%~dp0..\..") do set "PROJECT_ROOT=%%~fI"
set "TARGET_PATH=%PROJECT_ROOT%\start-ququ-dev.bat"
set "SHORTCUT_NAME=QuQu-Dev"
set "WORK_DIR=%PROJECT_ROOT%"
set "DESCRIPTION=Start QuQu App (Dev Mode)"
set "ICON_PATH=%PROJECT_ROOT%\assets\icon.ico"
REM ============================================================

echo.
echo 正在创建桌面快捷方式...
echo.

REM 创建VBScript临时文件
set "VBS_FILE=%TEMP%\create_shortcut_temp.vbs"
set "DESKTOP=%USERPROFILE%\Desktop"
set "SHORTCUT_PATH=%DESKTOP%\%SHORTCUT_NAME%.lnk"

(
echo Set WshShell = WScript.CreateObject^("WScript.Shell"^)
echo Set Shortcut = WshShell.CreateShortcut^("%SHORTCUT_PATH%"^)
echo Shortcut.TargetPath = "%TARGET_PATH%"
echo Shortcut.WorkingDirectory = "%WORK_DIR%"
echo Shortcut.Description = "%DESCRIPTION%"
echo Shortcut.IconLocation = "%ICON_PATH%"
echo Shortcut.Save
echo WScript.Echo "Shortcut created successfully!"
) > "%VBS_FILE%"

REM 执行VBScript
cscript //nologo "%VBS_FILE%"

REM 清理临时文件
del "%VBS_FILE%" >nul 2>&1

echo.
echo Shortcut created on desktop: %SHORTCUT_NAME%.lnk
echo.
pause

