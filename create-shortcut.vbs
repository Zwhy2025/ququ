' ============================================================
' 创建Windows桌面快捷方式脚本 (VBScript版本)
' ============================================================
' 使用方法：
'   1. 直接双击运行此文件（会使用默认配置）
'   2. 或者编辑此文件，修改下面的变量
' ============================================================

' ============ 配置区域 - 请根据需要修改 ============
TargetPath = "C:\Users\28678\Desktop\ququ\start-ququ-dev.bat"
ShortcutName = "QuQu-Dev"
WorkingDirectory = "C:\Users\28678\Desktop\ququ"
Description = "启动蛐蛐应用（开发模式）"
IconPath = "C:\Users\28678\Desktop\ququ\assets\icon.ico"
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
    WScript.Echo "✓ 已设置图标: " & IconPath
Else
    WScript.Echo "⚠ 图标文件不存在，使用默认图标: " & IconPath
End If

' 保存快捷方式
Shortcut.Save

' 输出结果
WScript.Echo ""
WScript.Echo "✓ 快捷方式创建成功！"
WScript.Echo "  名称: " & ShortcutName & ".lnk"
WScript.Echo "  位置: " & DesktopPath
WScript.Echo "  目标: " & TargetPath
WScript.Echo "  工作目录: " & WorkingDirectory
WScript.Echo ""

