#Requires AutoHotkey v2.0

; ! = Alt
; + = Shift
; ^ = Ctrl
; # = Win

; Adding Generators/Effects/Titles
Spawn(name, isEffect := false)
{
    if !isEffect
    {
        Send "{TAB}"
    }
    else
    {
        MouseClick
    }
    Sleep 100
    Send "^{Space}"
    SendInput name
    Send "{Enter}"
    if isEffect
    {
        return
    }
    Sleep 100
    Send "{TAB}"
}

DoEdit(shortcut)
{
    MouseClick
    Send "{TAB}"
    Send shortcut
}

DeselectAll()
{
    Send "^+d"
    Sleep 100
}

; =======================================
; Cutting
; =======================================

; Cut
F3:: {
    DoEdit("b")
    Sleep 100
    MouseMove 20, 0, 50, "R"
    MouseClick
    MouseMove -20, 0, 50, "R"
}

; Ripple Start
F1:: {
    DoEdit("q")
}   

; Ripple End
F2:: {
    DoEdit("w")
}

; Trim Start
+F1:: {
    DoEdit("a")
}   

; Trim End
+F2:: {
    DoEdit("s")
}


_trimDown := false
_shiftSpaceActive := false

~$LShift Up:: {
    global _shiftSpaceActive
    _shiftSpaceActive := false
}

~$RShift Up:: {
    global _shiftSpaceActive
    _shiftSpaceActive := false
}

+F3:: {
    global _trimDown
    if _trimDown
        return
    _trimDown := true
    Send "c"
    Send "{LButton Down}"
}

+F3 Up:: {
    global _trimDown
    Send "{LButton Up}"
    Send "v"
    _trimDown := false
} 

!+d:: {
    DeselectAll
    MouseClick
    Send "^c"
    Send "!{Up}"
    Send "^v"
    Send "{Up}"
}

; Move Playhead to cursor location and play, press multiple time to speed up
; $ prefix prevents Send "+{Space}" below from re-triggering this hotkey
$+Space:: {
    global _shiftSpaceActive
    if (A_PriorKey = "LShift" or A_PriorKey = "RShift" or _shiftSpaceActive) {
        _shiftSpaceActive := true
        Send "{Tab}"
        Sleep 50
        Send "l"
    } else {
        Send "+{Space}"
    }
}

; =======================================
; Titles/Generators/Effects
; =======================================

; Greg's Text+
F4:: {
    Spawn("Greg's Text+")
}

; Adjustment Clip
F5:: {
    Spawn("Adjustment Clip")
}

; Fusion Clip
F6:: {
    Spawn("Fusion Composition")
}

F7:: {
    Spawn("Gradual Animation Layer")
}

; Basic Mask
F8:: {
    Spawn("Basic Mask", true)
    Send "^+!9"
}

; Fade Up Animation
+F4:: {
    Spawn("AnimateAtoBEffect_FadeUp", true)
}

; Push Up Animation
+F5:: {
    Spawn("AnimateAtoBEffect_PushUp", true)
}

; WippMarker Clean
+F6:: {
    Spawn("WippMarker_Clean", true)
}

; WippHighlight Center
+F7:: {
    Spawn("WippHighlight_Center", true)
}

; Underlay
+F8:: {
    Spawn("WippUnderlay")
}