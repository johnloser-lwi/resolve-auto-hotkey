#Requires AutoHotkey v2.0

; Ctrl+Shift+Alt+O — open a project folder (ARoll/BRoll/Audio/Images/Footages)
; based on the current Resolve project's ProjectMedia location.
^+!o:: {
    script := A_ScriptDir "\utilities\open_project_folder.py"
    if !FileExist(script)
        script := A_ScriptDir "\open_project_folder.py"
    Run 'pythonw.exe "' script '"', , "Hide"
}
