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


_pluginMenu := Menu()
for name in _pluginModes {
    _pluginMenu.Add(name, SetMode)
}

^!q::_pluginMenu.Show()


#HotIf WinActive("ahk_exe Resolve.exe") && IsMode("GregTextPlus")
#Include GregTextPlus.ahk

#HotIf WinActive("ahk_exe Resolve.exe") && IsMode("WippZoom")
#Include WippZoom.ahk

#HotIf
