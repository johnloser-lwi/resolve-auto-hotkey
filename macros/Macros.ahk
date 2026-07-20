_macroModes := ["Edit"]
_macroMode  := _macroModes[1]

IsMacroMode(mode) {
    global _macroMode
    return _macroMode = mode
}

SetMacroMode(name, *) {
    global _macroMode, _macroMenu
    _macroMenu.Uncheck(_macroMode)
    _macroMode := name
    _macroMenu.Check(_macroMode)
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
