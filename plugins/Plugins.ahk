_pluginModes := ["GregTextPlus", "WippZoom"]
_pluginMode  := _pluginModes[1]

IsMode(mode) {
    global _pluginMode
    return _pluginMode = mode
}

SetMode(name, *) {
    global _pluginMode, _pluginMenu
    _pluginMenu.Uncheck(_pluginMode)
    _pluginMode := name
    _pluginMenu.Check(_pluginMode)
}

_pluginMenu := Menu()
_pluginMenu.Add("None", SetMode)
for name in _pluginModes {
    _pluginMenu.Add(name, SetMode)
}
_pluginMenu.Check(_pluginMode)

^!q::_pluginMenu.Show()


#HotIf WinActive("ahk_exe Resolve.exe") && IsMode("GregTextPlus")
#Include GregTextPlus.ahk

#HotIf WinActive("ahk_exe Resolve.exe") && IsMode("WippZoom")
#Include WippZoom.ahk

#HotIf
