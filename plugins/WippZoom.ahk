#Requires AutoHotkey v2.0

; ! = Alt
; + = Shift
; ^ = Ctrl
; # = Win

; --- Configure click position ---
; Use Ctrl+Shift+Alt+P while hovering over the button to find coordinates
MatchRefreshBtnX := 1694   ; <-- set me
MatchRefreshBtnY := 345   ; <-- set me

SwapBtnX := 1768
SwapBtnY := 345

RefreshSizeBtnX := 1859
RefreshSizeBtnY := 418

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
    MouseMove origX, origY
}

; Ctrl+Shift+Alt+Down — click and send Down
^!s:: {
    MouseGetPos &origX, &origY
    Click RefreshSizeBtnX, RefreshSizeBtnY
    Send "{Right}"
    Send "{Down}"
    MouseMove origX, origY
}
