#Requires AutoHotkey v2.0

; Cut
F3:: {
    MouseGetPos &mx, &my
    Click mx, my
    Send "{TAB}"
    Send "b"
}

; Ripple Start
F1:: {
    MouseGetPos &mx, &my
    Click mx, my
    Send "{TAB}"
    Send "q"
}   

; Ripple End
F2:: {
    MouseGetPos &mx, &my
    Click mx, my
    Send "{TAB}"
    Send "w"
}