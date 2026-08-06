_macroModes := ["Edit", "Fusion", "Color", "Fairlight", "Delivery"]
_macroMode  := _macroModes[1]

IsMacroMode(mode) {
    global _macroMode
    return _macroMode = mode
}

; Swiftpoint Z3 api command
SendCommand(Command) {
    ; 1. Open pipe with Read/Write access (0xC0000000)
    hPipe := DllCall("CreateFile", "Str", "\\.\pipe\swiftpoint.x1.v2.command", "UInt", 0xC0000000, "UInt", 0, "Ptr", 0, "UInt", 3, "UInt", 0, "Ptr", 0, "Ptr")
    
    if (hPipe = -1) {
        ToolTip('Could not connect to the X1 API pipe.')
        SetTimer(() => ToolTip(), -3000)
        return
    }

    ; 2. Write the command
    buf := Buffer(StrPut(Command, "UTF-8"))
    StrPut(Command, buf, "UTF-8")
    DllCall("WriteFile", "Ptr", hPipe, "Ptr", buf.Ptr, "UInt", buf.Size - 1, "UIntP", &bytesWritten := 0, "Ptr", 0)

    ; 3. Read the response
    resBuf := Buffer(1024, 0)
    response := ""
    if DllCall("ReadFile", "Ptr", hPipe, "Ptr", resBuf.Ptr, "UInt", resBuf.Size, "UIntP", &bytesRead := 0, "Ptr", 0) {
        response := StrGet(resBuf, bytesRead, "UTF-8")
        
        ; 4. Only show MsgBox if response is NOT "OK" (ignoring the newline)
        if (Trim(response, " `n`r") != "OK") {
            MsgBox("API Error/Response: " . response)
        }
    }

    ; 5. Clean up
    DllCall("CloseHandle", "Ptr", hPipe)
    
    return response
}

; WindowSwitch Callback to update the profile
DllCall("RegisterShellHookWindow", "Ptr", A_ScriptHwnd)
msgNum := DllCall("RegisterWindowMessage", "Str", "SHELLHOOK")
OnMessage(msgNum, shellMessage)

shellMessage(wParam, lParam, msg, hwnd) {
    ; HSHELL_WINDOWACTIVATED = 4, HSHELL_RUDEAPPACTIVATED = 32772 (0x8004)
    if (wParam = 4 || wParam = 32772) {
        activeHwnd := lParam
        try title := WinGetTitle(activeHwnd)
        catch
            title := "Unknown"
        
        if InStr(title, "DaVinci Resolve") {
            RefreshLayoutAndProfile(false)
        }
    }
}

RefreshLayoutAndProfile(swithPage := true) {
    if IsMacroMode("Edit") {
        if swithPage {
            Send "+4"
        }
        SendCommand("Profile SET DavinciResolve")
    } else if IsMacroMode("Fusion") {
        if swithPage {
            Send "h"
            Send "+5"
        }
        SendCommand("Profile SET Resolve-Fusion")
    } else if IsMacroMode("Color") {
        if swithPage {
            Send "+6"
        }
        SendCommand("Profile SET Resolve-Color")
    } else if IsMacroMode("Fairlight") {
        if swithPage {
            Send "+7"
        }
        SendCommand("Profile SET Resolve-Fairlight")
    } else if IsMacroMode("Delivery") {
        if swithPage {
            Send "+8"
        }
        SendCommand("Profile SET Resolve-Delivery")
    }
}

SetMacroMode(name, *) {
    global _macroMode
    _macroMode := name
    RefreshLayoutAndProfile()
}

_macroMenuItems := []
for name in _macroModes {
    _macroMenuItems.Push(name)
}

_holdMenuOpen := false

; Hold-to-select menu. Opens centered on the cursor and stays up while `key` is
; physically held; move the cursor over an item to highlight it, then release
; `key` to trigger it — no clicking. Releasing off the menu cancels.
;
; A native Menu can't do this: Menu.Show() blocks AHK's thread inside Windows'
; modal menu loop, so timers never fire and #HotIf can't be evaluated. A Gui
; doesn't block, so we poll the key and hover state ourselves.
ShowHoldMenu(items, key, callback, checked := "") {
    global _holdMenuOpen
    if _holdMenuOpen
        return
    _holdMenuOpen := true

    rowH := 26, w := 180, h := items.Length * rowH
    bg := "202020", bgHi := "0A64C8"

    g := Gui("-Caption +AlwaysOnTop +ToolWindow +E0x08000000")  ; NoActivate
    g.MarginX := 0, g.MarginY := 0
    g.BackColor := bg
    g.SetFont("s10 cWhite", "Segoe UI")

    rows := []
    for i, name in items {
        label := (name = checked ? "• " : "") name
        rows.Push(g.Add("Text", Format("x0 y{1} w{2} h{3} Center Background{4} +0x200"
            , (i - 1) * rowH, w, rowH, bg), label))
    }

    MouseGetPos &mx, &my
    g.Show(Format("x{1} y{2} w{3} h{4} NoActivate", mx - w // 2, my - h // 2, w, h))

    hot := 0   ; index of the currently highlighted row, 0 = none
    watch() {
        global _holdMenuOpen
        g.GetPos(&gx, &gy)
        MouseGetPos &cx, &cy
        idx := 0
        if (cx >= gx && cx < gx + w && cy >= gy && cy < gy + h)
            idx := (cy - gy) // rowH + 1

        if (idx != hot) {   ; repaint only on change to avoid flicker
            if hot
                rows[hot].Opt("Background" bg), rows[hot].Redraw()
            if idx
                rows[idx].Opt("Background" bgHi), rows[idx].Redraw()
            hot := idx
        }

        if !GetKeyState(key, "P") {   ; released — fire and close
            SetTimer(watch, 0)
            g.Destroy()
            _holdMenuOpen := false
            if hot
                callback(items[hot])
        }
    }
    SetTimer(watch, 15)
}

^+q::ShowHoldMenu(_macroMenuItems, "q", SetMacroMode, _macroMode)

#HotIf WinActive("ahk_exe Resolve.exe") && IsMacroMode("Edit")
#Include Edit.ahk


#HotIf

#HotIf WinActive("ahk_exe Resolve.exe") && IsMacroMode("Fusion")
#Include Fusion.ahk
#HotIf

#HotIf WinActive("ahk_exe Resolve.exe") && IsMacroMode("Color")
#Include Color.ahk
#HotIf

#HotIf WinActive("ahk_exe Resolve.exe") && IsMacroMode("Fairlight")
#Include Fairlight.ahk
#HotIf

#HotIf WinActive("ahk_exe Resolve.exe") && IsMacroMode("Delivery")
#Include Delivery.ahk
#HotIf

