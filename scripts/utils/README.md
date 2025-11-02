# 工具脚本目录

这个目录包含一些实用的工具脚本，可以辅助开发和项目维护。

## 快捷方式创建脚本

帮助您在Windows桌面上快速创建快捷方式，非常适合用于项目启动脚本的快捷方式创建。

### 脚本位置
```
scripts/utils/create-shortcut.ps1   (PowerShell版本，推荐)
scripts/utils/create-shortcut.bat   (批处理版本，最简单)
scripts/utils/create-shortcut.vbs   (VBScript版本，轻量级)
```

### 快速使用

**最简单的方式**：
```bash
# 直接双击运行
scripts\utils\create-shortcut.bat
```

**PowerShell方式**：
```powershell
cd scripts\utils
powershell -ExecutionPolicy Bypass -File create-shortcut.ps1
```

**带参数运行**：
```powershell
.\scripts\utils\create-shortcut.ps1 `
  -TargetPath "C:\path\to\script.bat" `
  -ShortcutName "我的应用" `
  -WorkingDirectory "C:\path\to\project" `
  -IconPath "C:\path\to\icon.ico"
```

### 配置方法

1. 打开任意脚本文件（推荐使用 `.bat` 或 `.vbs`）
2. 找到"配置区域"或变量定义部分
3. 修改以下配置：
   - `TARGET_PATH` / `TargetPath`: 目标文件路径
   - `SHORTCUT_NAME` / `ShortcutName`: 快捷方式名称
   - `WORK_DIR` / `WorkingDirectory`: 工作目录
   - `DESCRIPTION` / `Description`: 快捷方式描述
   - `ICON_PATH` / `IconPath`: 图标文件路径（可选）
4. 保存后运行脚本

### 三种版本对比

| 版本 | 优点 | 适用场景 |
|------|------|----------|
| PowerShell (`.ps1`) | 功能强大，支持参数 | 需要灵活配置或批量创建 |
| 批处理 (`.bat`) | 简单易用，兼容性好 | 快速一次性创建 |
| VBScript (`.vbs`) | 轻量级，无需权限 | 最基础的创建需求 |

### 使用示例

**为蛐蛐项目创建快捷方式**（使用默认自动路径）：
```powershell
# 方法1: 直接运行，脚本会自动检测项目根目录
.\scripts\utils\create-shortcut.ps1

# 方法2: 自定义名称和描述
.\scripts\utils\create-shortcut.ps1 `
  -ShortcutName "启动蛐蛐(开发模式)" `
  -Description "启动蛐蛐应用开发模式"
```

### 注意事项

- 图标文件不存在时，脚本会使用默认图标，不会报错
- PowerShell版本可能需要设置执行策略：`Set-ExecutionPolicy RemoteSigned -Scope CurrentUser`
- 路径中包含空格时会自动处理，无需手动加引号
- 可以创建多个快捷方式指向同一个目标，只需修改名称即可

