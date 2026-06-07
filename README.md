# ms-gamingoverlay Fix

**Languages:** [English](README.md) | [Русский](README-RU.md)

![screenshot](image.png)

> A small registry tweak for **Windows 10 LTSC** that silences the annoying `ms-gamingoverlay` search-overlay banner.
## ⚠️ Disclaimer

> **Use at your own risk.**
> This script modifies Windows registry keys and deletes temporary files. While these changes are non-destructive and limited in scope, the author provides this tool **"as is"**, without warranty of any kind. The author is **not responsible** for any damage, data loss, or system instability that may result from its use. Always create a registry backup (`regedit → File → Export`) before running scripts that edit the registry.

**Maintained by:** [mcbennet-coder](https://github.com/mcbennet-coder)

---

## What it does

Windows 10 LTSC ships without the Xbox / Gaming Services apps, yet the OS still tries to open `ms-gamingoverlay://` links. This produces a pop-up asking you to search the Store for an app to handle the protocol. The script suppresses that banner by:

1. Disabling **GameDVR** and **GameBar** via registry keys under `HKCU` and `HKLM`.
2. Removing the `ms-gamingoverlay` protocol association from the registry so Windows stops looking for a handler.
3. Deleting leftover temporary files from Gaming Services and Xbox App packages.

## Requirements

- Windows 10 LTSC (any build) - The author tested on Windows 10 IoT 21H2
- **Administrator privileges** (the script checks and exits if not elevated)

## Usage

1. Right-click `fix.bat` → **Run as administrator**.
2. The script will close Explorer, apply registry changes, clean temp files, then restart Explorer automatically.
3. Press any key when prompted to close the window.

## What the script changes

| Location | Key / Action | Value |
|---|---|---|
| `HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR` | `AppCaptureEnabled` | `0` |
| `HKCU\System\GameConfigStore` | `GameDVR_Enabled` | `0` |
| `HKCU\System\GameConfigStore` | `GameDVR_FSEBehaviorMode` | `2` |
| `HKCU\System\GameConfigStore` | `GameDVR_FSEBehavior` | `2` |
| `HKLM\SOFTWARE\Policies\Microsoft\Windows\GameDVR` | `AllowGameDVR` | `0` |
| `HKLM\SOFTWARE\Microsoft\PolicyManager\...` | `value` | `0` |
| `HKCU\SOFTWARE\Classes\ms-gamingoverlay` | *(key deleted)* | — |

Temporary files removed: `%localappdata%\Packages\Microsoft.GamingServices_*` and `Microsoft.XboxApp_*`.

## Reverting

Registry changes can be undone manually via `regedit.exe`. No system files are modified — only user-level and policy registry keys plus per-user temp data.


