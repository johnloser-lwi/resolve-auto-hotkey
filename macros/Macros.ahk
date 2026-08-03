_macroModes := ["Edit", "Fusion", "Color", "Fairlight"]
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
            RefreshLayoutAndProfile()
        }
    }
}

RefreshLayoutAndProfile() {
    if IsMacroMode("Edit") {
        Send "+4"
        SendCommand("Profile SET DavinciResolve")
    } else if IsMacroMode("Fusion") {
        Send "h"
        ;Send "+5"
        SendCommand("Profile SET Resolve-Fusion")
    } else if IsMacroMode("Color") {
        Send "+6"
        SendCommand("Profile SET Resolve-Color")
    } else if IsMacroMode("Fairlight") {
        Send "+7"
        SendCommand("Profile SET Resolve-Fairlight")
    }
}

SetMacroMode(name, *) {
    global _macroMode, _macroMenu
    _macroMenu.Uncheck(_macroMode)
    _macroMode := name
    _macroMenu.Check(_macroMode)
    RefreshLayoutAndProfile()
}

_macroMenu := Menu()
_macroMenu.Add("None", SetMacroMode)
for name in _macroModes {
    _macroMenu.Add(name, SetMacroMode)
}
_macroMenu.Check(_macroMode)

^+q::_macroMenu.Show()


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
