# 创建Windows桌面快捷方式脚本
# 使用方法：
#   1. 直接编辑此文件，修改下面的变量后运行
#   2. 或者使用参数: .\create-shortcut.ps1 -TargetPath "路径" -ShortcutName "名称"
#
# 示例: powershell -ExecutionPolicy Bypass -File create-shortcut.ps1

param(
    [string]$TargetPath = "",
    [string]$ShortcutName = "QuQu-Dev",
    [string]$WorkingDirectory = "",
    [string]$Description = "Start QuQu App (Dev Mode)",
    [string]$IconPath = ""
)

# 如果没有指定路径，自动使用脚本所在目录的项目根目录
if ([string]::IsNullOrEmpty($TargetPath) -or [string]::IsNullOrEmpty($WorkingDirectory) -or [string]::IsNullOrEmpty($IconPath)) {
    # 获取脚本所在目录
    if ($PSScriptRoot) {
        $scriptDir = $PSScriptRoot
    } else {
        $scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
        if ([string]::IsNullOrEmpty($scriptDir)) {
            $scriptDir = Split-Path -Parent $PSCommandPath
        }
    }
    
    # 项目根目录是脚本目录的上两级
    $projectRoot = (Get-Item (Join-Path $scriptDir "..\..")).FullName
    
    if ([string]::IsNullOrEmpty($TargetPath)) {
        $TargetPath = Join-Path $projectRoot "start-ququ-dev.bat"
    }
    
    if ([string]::IsNullOrEmpty($WorkingDirectory)) {
        $WorkingDirectory = $projectRoot
    }
    
    if ([string]::IsNullOrEmpty($IconPath)) {
        $IconPath = Join-Path $projectRoot "assets\icon.ico"
    }
}

# 获取桌面路径
$shell = New-Object -ComObject WScript.Shell
$desktop = $shell.SpecialFolders('Desktop')

# 创建快捷方式路径
$shortcutPath = Join-Path $desktop "$ShortcutName.lnk"

# 创建快捷方式
$shortcut = $shell.CreateShortcut($shortcutPath)
$shortcut.TargetPath = $TargetPath
$shortcut.WorkingDirectory = $WorkingDirectory
$shortcut.Description = $Description

# 如果图标文件存在，设置图标
if ($IconPath -and (Test-Path $IconPath)) {
    $shortcut.IconLocation = $IconPath
    Write-Host "Icon set: $IconPath" -ForegroundColor Cyan
} elseif ($IconPath) {
    Write-Host "Warning: Icon file not found, using default: $IconPath" -ForegroundColor Yellow
}

# 保存快捷方式
$shortcut.Save()

# 输出结果
Write-Host ""
Write-Host "Shortcut created successfully!" -ForegroundColor Green
Write-Host "  Name: $ShortcutName.lnk" -ForegroundColor White
Write-Host "  Location: $desktop" -ForegroundColor White
Write-Host "  Target: $TargetPath" -ForegroundColor White
Write-Host "  Working Directory: $WorkingDirectory" -ForegroundColor White
Write-Host ""

