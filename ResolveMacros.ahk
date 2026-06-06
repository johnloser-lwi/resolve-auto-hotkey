#Requires AutoHotkey v2.0

; General Utilities
#Include utilities\General.ahk
#Include utilities\Clipboard.ahk

; Plugin mode system — add new plugin names here to extend
_pluginModes := ["GregTextPlus", "WippZoom"]
_pluginMode  := _pluginModes[1]

IsMode(mode) {
    global _pluginMode
    return _pluginMode = mode
}

_pluginMenu := Menu()
for name in _pluginModes {
    _pluginMenu.Add(name, SetMode)
}

SetMode(name, *) {
    global _pluginMode
    _pluginMode := name
}

; Davinci Resolve Macros
#HotIf WinActive("ahk_exe Resolve.exe")
^!q::_pluginMenu.Show()
#Include macros\Edit.ahk

#HotIf WinActive("ahk_exe Resolve.exe") && IsMode("GregTextPlus")
#Include macros\plugins\GregTextPlus.ahk

#HotIf WinActive("ahk_exe Resolve.exe") && IsMode("WippZoom")
#Include macros\plugins\WippZoom.ahk

#HotIf
