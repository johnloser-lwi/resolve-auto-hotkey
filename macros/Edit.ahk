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
    Send "^!+{Right}"
}

; Ripple Start
F1:: {
    DoEdit("q")
}   

; Ripple End
F2:: {
    DoEdit("w")
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

; =======================================
; Titles/Generators/Effects
; =======================================

; Greg's Text+
F4:: {
    Spawn("Greg's Text+")
}

; John Simple Fill
F5:: {
    Spawn("John Simple Fill", true)
}

; John Simple Shadow
F6:: {
    Spawn("John Simple Shadow", true)
}

F7:: {
    Spawn("Gradual Animation Layer")
}

; Basic Mask
F8:: {
    Spawn("Basic Mask", true)
    Send "^+!9"
}

; Fade Right Animation
+F1:: {
    Spawn("AnimateAtoBEffect_FadeRight", true)
}

; Fade Left Animation
+F2:: {
    Spawn("AnimateAtoBEffect_FadeLeft", true)
}

; Fade Down Animation
+F3:: {
    Spawn("AnimateAtoBEffect_FadeDown", true)
}

; Fade Up Animation
+F4:: {
    Spawn("AnimateAtoBEffect_FadeUp", true)
}

; Push Up Animation
+F5:: {
    Spawn("Multi Transform", true)
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

; Render in place
!+3:: {
    Send "^+!1"
    Send "!+3"
}