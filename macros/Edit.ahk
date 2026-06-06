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
        MouseGetPos &mx, &my
        Click mx, my
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
    MouseGetPos &mx, &my
    Click mx, my
    Send "{TAB}"
    Send shortcut
}

; Cut
F3:: {
    DoEdit("b")
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