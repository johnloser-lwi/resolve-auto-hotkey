#Requires AutoHotkey v2.0

; ! = Alt
; + = Shift
; ^ = Ctrl
; # = Win


; Ctrl+Shift+Alt+P — show current mouse position in every coordinate system.
; Reporting all three matters: AHK v2 defaults Mouse to Client, so a bare
; MouseGetPos returns window-relative values that silently break when the
; target window moves, resizes, or sits on a monitor with a negative origin.
; Copy the value matching the CoordMode used by the script you're calibrating.
^+!p:: {
    CoordMode "Mouse", "Screen"
    MouseGetPos &sx, &sy
    CoordMode "Mouse", "Window"
    MouseGetPos &wx, &wy
    CoordMode "Mouse", "Client"
    MouseGetPos &cx, &cy
    try
        title := WinGetTitle("A")
    catch
        title := "(none)"

    MsgBox
    (
        "Screen  X=" sx "  Y=" sy "`n"
        "Window  X=" wx "  Y=" wy "`n"
        "Client  X=" cx "  Y=" cy "`n`n"
        "Active window: " title
    ), "Pointer Location", 64
}

; RAMMAP
^#!Delete:: {
    Run('powershell.exe -Command "D:\_TaskScheduler\RAMMap64.exe -Et"',, 'Hide')
}