#Requires AutoHotkey v2.0

; Win+Ctrl+Alt+E — activate the most-recent existing File Explorer window
; instead of always spawning a new one. If none is open, open a new one.
#^!Space:: {
    ; CabinetWClass = a normal Explorer file window (not the desktop/taskbar).
    hwnd := WinExist("ahk_class CabinetWClass")
    if !hwnd {
        Run "explorer.exe"
        return
    }
    WinActivate hwnd
}
