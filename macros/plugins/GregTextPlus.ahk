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

^!a::
{
    global _dragActive, X_XPos, X_YPos
    if _dragActive
        return
    _dragActive := true
    MouseMove X_XPos, X_YPos
    Send "{LButton Down}"
}
^!a Up::
{
    global _dragActive
    _dragActive := false
    Send "{LButton Up}"
}

^!w::
{
    global _dragActive, Y_XPos, Y_YPos
    if _dragActive
        return
    _dragActive := true
    MouseMove Y_XPos, Y_YPos
    Send "{LButton Down}"
}
^!w Up::
{
    global _dragActive
    _dragActive := false
    Send "{LButton Up}"
}

^!s::
{
    global _dragActive, Size_XPos, Size_YPos
    if _dragActive
        return
    _dragActive := true
    MouseMove Size_XPos, Size_YPos
    Send "{LButton Down}"
}
^!s Up::
{
    global _dragActive
    _dragActive := false
    Send "{LButton Up}"
}