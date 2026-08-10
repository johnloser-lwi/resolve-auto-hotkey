#Requires AutoHotkey v2.0

; All hardcoded control coordinates in this project are SCREEN-absolute.
; AHK v2 defaults Mouse/Pixel to Client (relative to the active window), which
; silently breaks whenever a window moves, resizes, or sits on a monitor with a
; negative origin — the cursor then lands on the wrong screen entirely. Setting
; this in the auto-execute section makes Screen the default for every thread.
; Recalibrate with Ctrl+Shift+Alt+P and use the "Screen" row.
CoordMode "Mouse", "Screen"
CoordMode "Pixel", "Screen"

; General Utilities
#Include utilities\General.ahk
#Include utilities\Clipboard.ahk
#Include utilities\OpenProjectFolder.ahk
#Include utilities\ExplorerFocus.ahk



; Macro layout switcher (Ctrl+Shift+Q)
#Include macros\Macros.ahk

; Plugin mode system
#Include plugins\Plugins.ahk
