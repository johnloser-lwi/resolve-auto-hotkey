#Requires AutoHotkey v2.0

; General Utilities
#Include utilities\General.ahk
#Include utilities\Clipboard.ahk


; Davinci Resolve Macros
#HotIf WinActive("ahk_exe Resolve.exe")

#Include macros\Edit.ahk
#Include macros\WippZoom.ahk
#Include macros\GregTextPlus.ahk