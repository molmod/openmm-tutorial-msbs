# Frequently asked questions

This page contains some technical issues often encountered on Windows and how to solve them.

## Permission Error when loading trajectory with NGLView

Windows users may not be able to load trajectories with NGLView.
This is due a bug, for which the fix can be found here: https://github.com/arose/nglview/pull/863

## Cannot open DLL, import failed

This may happen on Windows when trying to import a module in Python whose DLL file is opened by another process (and not properly closed).
The simple solution is to restart the kernel of your notebook: select the `Kernel` menu and then `Restart`.
If that did not help, try rebooting your computer.

## Cannot read some file, even when it is present

This may happen on Windows when the file was opened previously but not closed.
Restarting the kernel of your notebook should fix this.
