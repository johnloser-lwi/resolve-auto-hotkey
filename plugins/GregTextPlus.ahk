#Requires AutoHotkey v2.0

; ! = Alt
; + = Shift
; ^ = Ctrl
; # = Win

X_XPos := 2344
X_YPos := 535

Y_XPos := 2474
Y_YPos := 528

Size_XPos := 2479
Size_YPos := 554

_dragActive := false

_DragWhileHeld(xPos, yPos, key) {
    global _dragActive
    if _dragActive
        return
    _dragActive := true
    MouseMove xPos, yPos
    ; {Blind} keeps Send from releasing/re-pressing the physically held
    ; Ctrl+Alt around the click — that juggling is what left modifiers stuck.
    Send "{Blind}{LButton Down}"
    while GetKeyState(key, "P") && GetKeyState("Ctrl", "P") && GetKeyState("Alt", "P")
        Sleep 10
    Send "{Blind}{LButton Up}"
    ; once everything is physically released, clear any logically stuck modifiers
    KeyWait "Ctrl"
    KeyWait "Alt"
    for mod in ["LCtrl", "RCtrl", "LAlt", "RAlt", "LShift", "RShift"] {
        if GetKeyState(mod)
            Send "{Blind}{" mod " up}"
    }
    _dragActive := false
}

^!a:: _DragWhileHeld(X_XPos, X_YPos, "a")
^!w:: _DragWhileHeld(Y_XPos, Y_YPos, "w")
^!s:: _DragWhileHeld(Size_XPos, Size_YPos, "s")