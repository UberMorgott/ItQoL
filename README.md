# ItQoL

Small scripts to automate routine processes for IT system admins.

## Online Install ALL Visual C++ Redistributable & DirectX

Automatically downloads and installs all Visual C++ Redistributable packages (2005–2022, x86 + x64) and DirectX June 2010 from official Microsoft servers. Uses pipeline architecture — downloads the next package while installing the current one.

### Quick Start

1. Open **PowerShell** or **CMD** as **Administrator** (right-click → Run as Administrator)
2. Paste the command and press Enter:

**PowerShell:**
```powershell
iwr "https://raw.githubusercontent.com/UberMorgott/ItQoL/main/Online%20Install%20ALL%20Visual%20C%2B%2B%20Redistributable.bat" -OutFile "$env:TEMP\vc.bat"; cmd /c "$env:TEMP\vc.bat"
```

**CMD:**
```cmd
curl -sL "https://raw.githubusercontent.com/UberMorgott/ItQoL/main/Online%20Install%20ALL%20Visual%20C%2B%2B%20Redistributable.bat" -o "%TEMP%\vc.bat" && "%TEMP%\vc.bat"
```

> **Important:** The terminal must be run as Administrator. If you forget, the script will request UAC elevation automatically.

### What gets installed

| Package | Versions |
|---|---|
| Visual C++ 2005 | x86, x64 |
| Visual C++ 2008 | x86, x64 |
| Visual C++ 2010 | x86, x64 |
| Visual C++ 2012 | x86, x64 |
| Visual C++ 2013 | x86, x64 |
| Visual C++ 2015–2022 | x86, x64 |
| DirectX June 2010 | — |

### Features

- Downloads from official Microsoft servers only
- Pipeline: downloads next package while installing current one
- Silent installation — no prompts or popups
- Works with any PowerShell execution policy
- Auto-cleans temp files after completion
