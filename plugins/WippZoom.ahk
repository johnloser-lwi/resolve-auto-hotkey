#Requires AutoHotkey v2.0

; ! = Alt
; + = Shift
; ^ = Ctrl
; # = Win

; --- Configure click position (SCREEN-absolute) ---
; Use Ctrl+Shift+Alt+P while hovering over the button and take the "Screen" row.
; Screen mode is set globally in ResolveMacros.ahk; these break if Resolve is
; moved, resized, or switched between single- and dual-screen layouts.
MatchRefreshBtnX := 2245   ; <-- set me
MatchRefreshBtnY := 344   ; <-- set me

SwapBtnX := 2434
SwapBtnY := 350

RefreshSizeBtnX := 2477
RefreshSizeBtnY := 428

^!a:: {
    MouseGetPos &origX, &origY
    Click MatchRefreshBtnX, MatchRefreshBtnY
    MouseMove origX, origY
}

^!d:: {
    MouseGetPos &origX, &origY
    Click SwapBtnX, SwapBtnY
    MouseMove origX, origY
}

; Ctrl+Shift+Alt+Up — click and send Up
^!w:: {
    MouseGetPos &origX, &origY
    Click RefreshSizeBtnX, RefreshSizeBtnY
    Send "{Right}"
    Send "{Up}"
    Click RefreshSizeBtnX + 30, RefreshSizeBtnY
    MouseMove origX, origY
}

; Ctrl+Shift+Alt+Down — click and send Down
^!s:: {
    MouseGetPos &origX, &origY
    Click RefreshSizeBtnX, RefreshSizeBtnY
    Send "{Right}"
    Send "{Down}"
    Click RefreshSizeBtnX + 30, RefreshSizeBtnY
    MouseMove origX, origY
}
