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

## Clipboard Utilities (`utilities/Clipboard.ahk`)

| Shortcut             | Action                        |
|----------------------|-------------------------------|
| `Ctrl+Shift+Alt+V`   | Convert clipboard text case   |

Pressing `Ctrl+Shift+Alt+V` opens a menu with three options applied to the current clipboard contents:

| Option                  | Description                                                                 | Example                          |
|-------------------------|-----------------------------------------------------------------------------|----------------------------------|
| **ALL CAPS**            | Every letter uppercase                                                      | `hello world` → `HELLO WORLD`   |
| **Title Case**          | Capitalize each word; articles, conjunctions, and short prepositions stay lowercase (first and last word always capitalized) | `the lord of the rings` → `The Lord of the Rings` |
| **Capitalize Each Word**| Uppercase only the first letter of each word, leave remaining letters as-is | `hELLO wORLD` → `HELLO WORLD`   |

Minor words kept lowercase in Title Case: `a an the and but or nor for so yet at by in of on to up as via`

---

## General Utilities (`utilities/General.ahk`)

| Shortcut             | Action                         |
|----------------------|--------------------------------|
| `Ctrl+Shift+Alt+P`   | Show current mouse coordinates |

---

## WippZoom Shortcuts (`macros/WippZoom.ahk`)

| Shortcut                | Action                              |
|-------------------------|-------------------------------------|
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
