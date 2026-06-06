# Resolve AutoHotkey Macros

AutoHotkey v2 macros for DaVinci Resolve. All shortcuts are active **only when Resolve is the focused window**.

---

## Edit Shortcuts (`macros/Edit.ahk`)

### Editing

| Shortcut   | Action        |
|------------|---------------|
| `F1`       | Ripple Start  |
| `F2`       | Ripple End    |
| `F3`       | Cut           |
| `Shift+F1` | Trim Start    |
| `Shift+F2` | Trim End      |

### Generators / Titles

| Shortcut   | Action                   |
|------------|--------------------------|
| `F4`       | Greg's Text+             |
| `F5`       | Adjustment Clip          |
| `F6`       | Fusion Composition       |
| `F7`       | Gradual Animation Layer  |
| `Shift+F8` | WippUnderlay             |

### Effects

| Shortcut   | Action                    |
|------------|---------------------------|
| `F8`       | Basic Mask                |
| `Shift+F4` | Fade Up Animation         |
| `Shift+F5` | Push Up Animation         |
| `Shift+F6` | WippMarker Clean          |
| `Shift+F7` | WippHighlight Center      |

---

## WippZoom Shortcuts (`macros/WippZoom.ahk`)

| Shortcut                | Action                              |
|-------------------------|-------------------------------------|
| `Ctrl+Shift+Alt+P`      | Show current mouse coordinates      |
| `Ctrl+Shift+Alt+Left`   | Refresh match (click MatchRefresh)  |
| `Ctrl+Shift+Alt+Right`  | Swap                                |
| `Ctrl+Shift+Alt+Up`     | Refresh size, increment up          |
| `Ctrl+Shift+Alt+Down`   | Refresh size, increment down        |

> **Setup:** Before using WippZoom, update the button coordinates in `macros/WippZoom.ahk`.
> Hover over each button in Resolve and press `Ctrl+Shift+Alt+P` to get the X/Y values.

---

## Usage

1. Install [AutoHotkey v2](https://www.autohotkey.com/)
2. Run `ResolveMacros.ahk`
3. Open DaVinci Resolve — shortcuts activate automatically
