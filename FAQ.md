# Frequently asked questions

This page contains some technical issues often encountered and how to solve them.

## Kernel Error, notebooks do not work

If you get a "kernel error" on Windows, you might be running into the following issue (or a similar one): https://github.com/jupyter/notebook/issues/4907. this should be in principle solved with the `jupyter_client>=5.3.4` and `jupyter_core>=4.6.1`, available on conda-forge as of November 17, 2019. In case you still run into this issue, try to downgrade `jupyter_client` to version 5.3.1 as follows on your Conda prompt:

## Permission Error when loading trajectory with NGLView

Windows users may not be able to load trajectories with NGLView. This is due a bug, for which the fix can be found here: https://github.com/arose/nglview/pull/863

## Cannot open DLL, import failed

This may happen on Windows when trying to import a module in Python whose DLL file is opened by another process (and not properly closed). The simple solution is to restart the kernel of your notebook: select the `Kernel` menu and then `Restart`. If that did not help, try rebooting your computer.

## Cannot read some file, even when it is present

This may happen on Windows when the file was opened previously but not closed. Restarting the kernel of your notebook should fix this.
