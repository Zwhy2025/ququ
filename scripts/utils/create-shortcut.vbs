' ============================================================
' 创建Windows桌面快捷方式脚本 (VBScript版本)
' ============================================================
' 使用方法：
'   1. 直接双击运行此文件（会使用默认配置）
'   2. 或者编辑此文件，修改下面的变量
' ============================================================

' ============ 配置区域 - 请根据需要修改 ============
' 自动获取项目根目录（脚本所在目录的上两级目录）
Set fso = CreateObject("Scripting.FileSystemObject")
ScriptPath = fso.GetParentFolderName(WScript.ScriptFullName)
ProjectRoot = fso.GetParentFolderName(fso.GetParentFolderName(ScriptPath))

TargetPath = ProjectRoot & "\start-ququ-dev.bat"
ShortcutName = "QuQu-Dev"
WorkingDirectory = ProjectRoot
Description = "Start QuQu App (Dev Mode)"
IconPath = ProjectRoot & "\assets\icon.ico"
' ============================================================

Set WshShell = WScript.CreateObject("WScript.Shell")
Set fso = CreateObject("Scripting.FileSystemObject")

' 获取桌面路径
DesktopPath = WshShell.SpecialFolders("Desktop")
ShortcutPath = DesktopPath & "\" & ShortcutName & ".lnk"

' 创建快捷方式
Set Shortcut = WshShell.CreateShortcut(ShortcutPath)
Shortcut.TargetPath = TargetPath
Shortcut.WorkingDirectory = WorkingDirectory
Shortcut.Description = Description

' 检查图标文件是否存在
If fso.FileExists(IconPath) Then
    Shortcut.IconLocation = IconPath
    WScript.Echo "Icon set: " & IconPath
Else
    WScript.Echo "Warning: Icon file not found: " & IconPath
End If

' 保存快捷方式
Shortcut.Save

' 输出结果
WScript.Echo ""
WScript.Echo "Shortcut created successfully!"
WScript.Echo "  Name: " & ShortcutName & ".lnk"
WScript.Echo "  Location: " & DesktopPath
WScript.Echo "  Target: " & TargetPath
WScript.Echo "  Working Directory: " & WorkingDirectory
WScript.Echo ""

