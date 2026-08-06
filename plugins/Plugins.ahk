_pluginModes := ["GregTextPlus", "WippZoom"]
_pluginMode  := _pluginModes[1]

IsMode(mode) {
    global _pluginMode
    return _pluginMode = mode
}

SetMode(name, *) {
    global _pluginMode
    _pluginMode := name
}

; "None" disables all plugins; ShowHoldMenu is defined in macros/Macros.ahk.
_pluginMenuItems := []
for name in _pluginModes {
    _pluginMenuItems.Push(name)
}

^!q::ShowHoldMenu(_pluginMenuItems, "q", SetMode, _pluginMode)


#HotIf WinActive("ahk_exe Resolve.exe") && IsMode("GregTextPlus")
#Include GregTextPlus.ahk

#HotIf WinActive("ahk_exe Resolve.exe") && IsMode("WippZoom")
#Include WippZoom.ahk

#HotIf
