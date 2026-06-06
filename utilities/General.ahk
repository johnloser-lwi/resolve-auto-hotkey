#Requires AutoHotkey v2.0

; ! = Alt
; + = Shift
; ^ = Ctrl
; # = Win


; Ctrl+Shift+Alt+P — show current mouse position
^+!p:: {
    MouseGetPos &mx, &my
    MsgBox "Mouse is at X=" mx "  Y=" my, "Pointer Location", 64
}