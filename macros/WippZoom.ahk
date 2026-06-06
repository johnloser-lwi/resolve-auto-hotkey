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

; Ctrl+Shift+Alt+P — show current mouse position
^+!p:: {
    MouseGetPos &mx, &my
    MsgBox "Mouse is at X=" mx "  Y=" my, "WippZoom Picker", 64
}

^+!Left:: {
    MouseGetPos &origX, &origY
    Click origX, origY
    Click MatchRefreshBtnX, MatchRefreshBtnY
    Click origX, origY
}

^+!Right:: {
    MouseGetPos &origX, &origY
    Click origX, origY
    Click SwapBtnX, SwapBtnY
    Click origX, origY
}

; Ctrl+Shift+Alt+Up — click and send Up
^+!Up:: {
    MouseGetPos &origX, &origY
    Click origX, origY
    Click RefreshSizeBtnX, RefreshSizeBtnY
    Send "{Right}"
    Send "{Up}"
    Click origX, origY
}

; Ctrl+Shift+Alt+Down — click and send Down
^+!Down:: {
    MouseGetPos &origX, &origY
    Click origX, origY
    Click RefreshSizeBtnX, RefreshSizeBtnY
    Send "{Right}"
    Send "{Down}"
    Click origX, origY
}
