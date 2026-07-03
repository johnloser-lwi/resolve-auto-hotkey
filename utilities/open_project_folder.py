"""Open a project subfolder based on the current Resolve project's ProjectMedia location.

Reads the "Project media location" working folder from the current project's
settings (projectMediaLocation), derives the project root from it, then shows
a small menu to open ARoll / BRoll / Audio / Images / Footages (or the root)
in Explorer.

Triggered from AutoHotkey (see utilities/OpenProjectFolder.ahk).
"""

import os
import sys
import tkinter as tk
from tkinter import messagebox

RESOLVE_MODULES = os.path.join(
    os.environ.get("PROGRAMDATA", r"C:\ProgramData"),
    r"Blackmagic Design\DaVinci Resolve\Support\Developer\Scripting\Modules",
)

# label -> path relative to project root
FOLDERS = [
    ("ARoll", os.path.join("Captures", "ARoll")),
    ("BRoll", os.path.join("Captures", "BRoll")),
    ("Audio", os.path.join("Captures", "Audio")),
    ("Images", "Images"),
    ("Footages", "Footages"),
    ("Project Root", ""),
]


def get_resolve():
    sys.path.insert(0, RESOLVE_MODULES)
    try:
        import DaVinciResolveScript as dvr
    except ImportError:
        return None
    return dvr.scriptapp("Resolve")


def find_project_root(project):
    """Return the parent of the project's "Project media location" setting."""
    media_location = project.GetSetting("projectMediaLocation")
    if not media_location:
        return None
    return os.path.dirname(os.path.normpath(media_location))


def fail(msg):
    root = tk.Tk()
    root.withdraw()
    messagebox.showerror("Open Project Folder", msg)
    sys.exit(1)


def show_menu(project_root, project_name):
    win = tk.Tk()
    win.title(project_name)
    win.attributes("-topmost", True)
    win.resizable(False, False)
    win.configure(padx=12, pady=10)

    def open_folder(rel):
        target = os.path.join(project_root, rel) if rel else project_root
        win.destroy()
        if os.path.isdir(target):
            os.startfile(target)
        else:
            fail(f"Folder not found:\n{target}")

    tk.Label(win, text=project_root, fg="#666").pack(anchor="w", pady=(0, 8))

    for i, (label, rel) in enumerate(FOLDERS, start=1):
        btn = tk.Button(
            win,
            text=f"{i}. {label}",
            width=24,
            anchor="w",
            command=lambda r=rel: open_folder(r),
        )
        btn.pack(fill="x", pady=2)
        win.bind(str(i), lambda _e, r=rel: open_folder(r))

    win.bind("<Escape>", lambda _e: win.destroy())

    # center on screen and focus so number keys work immediately
    win.update_idletasks()
    x = (win.winfo_screenwidth() - win.winfo_width()) // 2
    y = (win.winfo_screenheight() - win.winfo_height()) // 2
    win.geometry(f"+{x}+{y}")
    win.focus_force()
    win.mainloop()


def main():
    resolve = get_resolve()
    if resolve is None:
        fail("Could not connect to DaVinci Resolve.\nIs it running with scripting enabled?")

    project = resolve.GetProjectManager().GetCurrentProject()
    if project is None:
        fail("No project is currently open in Resolve.")

    project_root = find_project_root(project)
    if project_root is None:
        fail(
            "The 'Project media location' working folder is not set for this project.\n"
            "Set it in Project Settings > General Options > Working Folders."
        )

    show_menu(project_root, project.GetName())


if __name__ == "__main__":
    main()
