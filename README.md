# Cozy Hearth – WezTerm Configuration

A warm, earthy dark theme for [WezTerm](https://wezfurlong.org/wezterm/) with process-aware tab titles, Nerd Font icons, and a clean Windows-focused setup.

---

## Theme Overview

**Cozy Hearth** uses a deep charcoal background with muted warm accents:

| Role              | Color     | Hex       |
|-------------------|-----------|-----------|
| Background        | Dark brown| `#13100E` |
| Foreground        | Warm beige| `#BFB49E` |
| Tab background    | Soft brown| `#1E1A16` |
| Accent / Unseen   | Amber     | `#CC9038` |
| Cursor            | Warm gold | `#B87A2A` |

The palette is intentionally low-contrast and soft on the eyes for long terminal sessions.

---

## Features

- **Process icons** in tab titles (PowerShell, CMD, WSL, Bash, Zsh, Fish, Neovim, Git, Node, Python, Docker, SSH, etc.)
- **Unseen output indicator** – inactive tabs with new output turn amber
- **Custom tab title** – shows process name or custom tab title with icon
- **Launch menu** – quick access to PowerShell, Command Prompt, and WSL
- **Default shell** – PowerShell (`pwsh.exe -NoLogo`)
- **Maple Mono Nerd Font** (Thin weight)
- **Acrylic backdrop** + 92% opacity (Windows)
- **Fancy tab bar** with integrated titlebar buttons
- **Blinking bar cursor**
- **WebGpu** frontend
- Audible bell disabled

---

## Requirements

- [WezTerm](https://wezfurlong.org/wezterm/) (recent nightly or stable)
- [Maple Mono Nerd Font](https://github.com/subframe7536/maple-font) (or any Nerd Font that includes the icons used)
- PowerShell 7+ recommended (`pwsh.exe`)
- Windows (Acrylic backdrop is Windows-only; the rest works cross-platform)

---

## Installation

1. Copy the configuration file to your WezTerm config location:

   ```powershell
   # Typical location on Windows
   $env:USERPROFILE\.wezterm.lua
