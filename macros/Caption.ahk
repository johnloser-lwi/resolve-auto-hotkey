; --- Field coordinates (SCREEN-absolute) ---
; Use Ctrl+Shift+Alt+P while hovering over the field and take the "Screen" row.
; Screen mode is set globally in ResolveMacros.ahk.
IN_XPos := 1599
IN_YPos := 240
OUT_XPos := 1720
OUT_YPos := 241
PREV_XPos := 1777
PREV_YPos := 408

; Copy the in point of the subtitle to the out point of the previous subtitle, closing the gaps
CopyInToOut() {
    global IN_XPos, IN_YPos, OUT_XPos, OUT_YPos, PREV_XPos, PREV_YPos
    Click IN_XPos, IN_YPos
    Send "^a"

    Sleep 100

    Send "^c"

    Click PREV_XPos, PREV_YPos
    Sleep 500

    Click OUT_XPos, OUT_YPos
    Send "^a"
    Send "^v"
    Send "{Enter}"
}

_captionRunning := false

; Start Operation
#MaxThreadsPerHotkey 1
F1:: {
    global _captionRunning
    _captionRunning := true
    while _captionRunning
        CopyInToOut()
}

; Stop Operation
F2:: {
    global _captionRunning
    _captionRunning := false
}

; Manual Copy
F3:: {
    MouseGetPos &origX, &origY
    MouseClick
    CopyInToOut()
    MouseMove origX, origY
}
