#Requires AutoHotkey v2.0

; ! = Alt
; + = Shift
; ^ = Ctrl
; # = Win

X_XPos := 1697
X_YPos := 537

Y_XPos := 1847
Y_YPos := 538

Size_XPos := 1834
Size_YPos := 566

_dragActive := false

_DragWhileHeld(xPos, yPos, key) {
    global _dragActive
    if _dragActive
        return
    _dragActive := true
    MouseMove xPos, yPos
    Send "{LButton Down}"
    ih := InputHook("L0 V")
    ih.KeyOpt("{All}", "E")
    ih.Start()
    while ih.InProgress && GetKeyState(key, "P") && GetKeyState("Ctrl", "P") && GetKeyState("Alt", "P")
        Sleep 10
    ih.Stop()
    _dragActive := false
    Send "{LButton Up}"
    if !GetKeyState("Ctrl", "P")
        Send "{Ctrl Up}"
    if !GetKeyState("Alt", "P")
        Send "{Alt Up}"
}

^!a:: _DragWhileHeld(X_XPos, X_YPos, "a")
^!w:: _DragWhileHeld(Y_XPos, Y_YPos, "w")
^!s:: _DragWhileHeld(Size_XPos, Size_YPos, "s")