# Resolve AutoHotkey Macros

AutoHotkey v2 macros for DaVinci Resolve. All shortcuts are active **only when Resolve is the focused window**.

---

## Plugin Mode (`Ctrl+Alt+Q`)

WippZoom and GregTextPlus are mutually exclusive — only one is active at a time. Press `Ctrl+Alt+Q` to open a menu and select the active plugin. This frees up shortcut space that would otherwise be wasted keeping both active simultaneously.

To add a future plugin: drop its `.ahk` file in `macros/plugins/`, add its name to `_pluginModes` in `ResolveMacros.ahk`, and add a `#HotIf ... && IsMode("Name")` + `#Include` block.

---

## Edit Shortcuts (`macros/Edit.ahk`)

Always active in Resolve, regardless of plugin mode.

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

## GregTextPlus Plugin (`macros/plugins/GregTextPlus.ahk`)

Hold the shortcut to move the mouse to that control and hold the left button down. Drag left/right to adjust the value. Release the key to let go.

| Shortcut         | Action       |
|------------------|--------------|
| `Ctrl+Alt+A`     | Drag X       |
| `Ctrl+Alt+W`     | Drag Y       |
| `Ctrl+Alt+S`     | Drag Size    |

> **Setup:** Update the control coordinates at the top of `macros/plugins/GregTextPlus.ahk`.
> Hover over each slider in Resolve and press `Ctrl+Shift+Alt+P` to get the X/Y values.

---

## WippZoom Plugin (`macros/plugins/WippZoom.ahk`)

| Shortcut       | Action                             |
|----------------|------------------------------------|
| `Ctrl+Alt+A`   | Refresh match (click MatchRefresh) |
| `Ctrl+Alt+D`   | Swap                               |
| `Ctrl+Alt+W`   | Refresh size, increment up         |
| `Ctrl+Alt+S`   | Refresh size, increment down       |

> **Setup:** Update the button coordinates at the top of `macros/plugins/WippZoom.ahk`.
> Hover over each button in Resolve and press `Ctrl+Shift+Alt+P` to get the X/Y values.

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

## Usage

1. Install [AutoHotkey v2](https://www.autohotkey.com/)
2. Run `ResolveMacros.ahk`
3. Open DaVinci Resolve — shortcuts activate automatically
4. Press `Ctrl+Alt+Q` to select the active plugin (defaults to GregTextPlus)
