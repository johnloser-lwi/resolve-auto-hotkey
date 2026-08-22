#Requires AutoHotkey v2.0

; ! = Alt
; + = Shift
; ^ = Ctrl
; # = Win

; ---------------------------------------------------------------------------
; Quick-apply slots (StarCraft-style control groups for Fusion nodes)
;
;   Ctrl+Shift+1..9, Ctrl+Shift+0   copy the selected nodes, save to slot 1..10
;   Ctrl+1..9, Ctrl+0               paste slot 1..10 into the node editor
;   (the 0 key is slot 10)
;
; Each slot is a plain-text file in slots\ next to the script. Fusion copies
; nodes as Lua text, which can be hundreds of KB, and a file has no size limit,
; survives script reloads and reboots, and can be opened to see what it holds.
; ---------------------------------------------------------------------------

_slotDir := A_ScriptDir "\slots"

_SlotPath(n) => _slotDir "\fusion_slot" n ".txt"

_SlotTip(msg) {
    ToolTip msg
    SetTimer(() => ToolTip(), -1200)
}

SaveSlot(n) {
    global _slotDir
    DirCreate _slotDir

    ; Clear first so ClipWait can tell a fresh copy apart from the old contents.
    prev := ClipboardAll()
    A_Clipboard := ""
    Send "^c"
    if !ClipWait(1) {
        A_Clipboard := prev   ; nothing was copied (no selection) — put it back
        _SlotTip "Slot " n ": nothing selected"
        return
    }

    path := _SlotPath(n)
    if FileExist(path)
        FileDelete path
    FileAppend A_Clipboard, path, "UTF-8"
    _SlotTip "Saved slot " n " (" StrLen(A_Clipboard) " chars)"
}

PasteSlot(n) {
    path := _SlotPath(n)
    if !FileExist(path) {
        _SlotTip "Slot " n " is empty — Ctrl+Shift+" Mod(n, 10) " to save"
        return
    }
    A_Clipboard := FileRead(path, "UTF-8")
    ClipWait 1
    Send "^v"
    _SlotTip "Pasted slot " n
}

; Number row: keys 1..9 are slots 1..9, key 0 is slot 10.
; Written out explicitly so they stay inside the #HotIf Fusion-mode guard
; (Hotkey() would ignore the directive) and avoid shared loop-variable closures.
^+1::SaveSlot(1)
^+2::SaveSlot(2)
^+3::SaveSlot(3)
^+4::SaveSlot(4)
^+5::SaveSlot(5)
^+6::SaveSlot(6)
^+7::SaveSlot(7)
^+8::SaveSlot(8)
^+9::SaveSlot(9)
^+0::SaveSlot(10)

^1::PasteSlot(1)
^2::PasteSlot(2)
^3::PasteSlot(3)
^4::PasteSlot(4)
^5::PasteSlot(5)
^6::PasteSlot(6)
^7::PasteSlot(7)
^8::PasteSlot(8)
^9::PasteSlot(9)
^0::PasteSlot(10)
