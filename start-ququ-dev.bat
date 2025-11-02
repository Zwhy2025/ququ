@echo off
chcp 65001 >nul
REM 蛐蛐应用开发模式启动脚本
REM 这是一个批处理文件，双击即可启动应用
REM 自动获取脚本所在目录作为项目根目录

REM 自动获取脚本所在目录（项目根目录）
cd /d "%~dp0"

REM 检查是否安装了依赖（检查关键模块是否存在）
if not exist "node_modules" (
    echo 检测到未安装依赖，正在安装...
    where pnpm >nul 2>nul
    if %errorlevel% equ 0 (
        call pnpm install
    ) else (
        call npm install
    )
    if errorlevel 1 (
        echo 依赖安装失败，请检查网络连接和包管理器配置
        pause
        exit /b 1
    )
) else (
    REM 检查关键依赖是否存在
    if not exist "node_modules\concurrently" (
        echo 检测到依赖不完整，正在重新安装...
        where pnpm >nul 2>nul
        if %errorlevel% equ 0 (
            call pnpm install
        ) else (
            call npm install
        )
        if errorlevel 1 (
            echo 依赖安装失败，请检查网络连接和包管理器配置
            pause
            exit /b 1
        )
    )
)

echo 正在启动蛐蛐应用（开发模式）...
echo 项目路径: %CD%

REM 尝试使用pnpm，如果不存在则使用npm
where pnpm >nul 2>nul
if %errorlevel% equ 0 (
    echo 使用 pnpm 启动...
    call pnpm run dev
) else (
    echo 使用 npm 启动...
    call npm run dev
)

pause

