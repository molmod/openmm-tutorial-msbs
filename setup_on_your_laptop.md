# Installation of OpenMM on your laptop

To run OpenMM simulations on your laptop, we will work with a standardized Python environment, Anaconda, which is supported on all major operating systems.

Some of the more specialized packages (required for tutorial 07) are only used on Unix systems (Linux and macOS) by researchers in the field, and these have poor support on Windows.
Luckily, on Windows 10, Microsoft distributes the Windows Subsystem for Linux 2 (WSL2), as of a May 2019.
This allows you to run Linux inside your Windows operating system, giving you access to a small-scale version the software environment used on high-performance cluster.
More details can be found in the [Official WSL installation instructions](https://docs.microsoft.com/en-us/windows/wsl/install-win10).
For this course, WSL2 is optional and left to those interested in a little extra hacking.

Take the following steps:

1. Download the Anaconda Python 3.8 installer for your operating system.
   The installer can be downloaded from [the anaconda website](https://www.anaconda.com/distribution/).

1. Run the Anaconda Python installer.

   **Windows.** Run the `.exe` installer.

   **macOS.** TODO

   **Linux.** Enter the following command in a virtual terminal:

   ```bash
   bash Anaconda*-Linux-x86_64.sh -b -p ${HOME}/anaconda
   ```

   Add the following line to your `~/.bashrc` file, which makes it convenient to activate the conda installation:

   ```
   alias c='source ~/anaconda/bin/activate'
   ```

1. Start a command-line prompt.

   **Windows.** Run the application "Anaconda prompt" from the start menu.

   **macOS.** TODO

   **Linux.** Open your preferred virtual terminal and enter the command alias `c`.


1. Configure conda and install OpenMM (and other useful tools).

   In this step, you all need to enter commands in a virtual terminal, the software equivalent of terminal computers from the 70's.
   Every command you enter will be executed after you press `Enter`.
   Possibly some output is shown as a result, but not always.
   Virtual terminals are very powerful tools, but they are also picky!
   Almost every character or whitespace you type does matter.

   **Windows.** Copy the following lines **one by one** in the anaconda terminal.

   **macOS or Linux.** Run the following commands in a virtual terminal. You can copy-paste all lines in one go.

   (Lines startin with `#` are comments and can be ignored.)

   ```bash
   conda config --add channels conda-forge
   # The following creates a conda environment called openmm
   # in which a several packages are installed.
   conda create -n openmm cudatoolkit=10.0 git jupyterlab numpy pandas scipy matplotlib ipympl rdkit openbabel openmm mdtraj nglview pymbar pdbfixer parmed openff-toolkit openmoltools openmmforcefields
   # Activate the environment just created.
   conda activate openmm
   # Enable nglview in jupyter notebooks
   jupyter-nbextension enable nglview --py --sys-prefix
   ```

1. Test your OpenMM installation by entering the following command on the command prompt:

   ```bash
   python -m openmm.testInstallation
   ```

   You should see the following output (or something similar):

   ```
   OpenMM Version: 7.6
   Git Revision: ad113a0cb37991a2de67a08026cf3b91616bafbe

   There are 2 Platforms available:

   1 Reference - Successfully computed forces
   2 CPU - Successfully computed forces

   Median difference in forces between platforms:

   Reference vs. CPU: 6.2929e-06

   All differences are within tolerance.
   ```


1. Now is a good time to become more familiar with Jupyter Lab. The following link provide easy-to-follow guides, which will get you up to speed:

   - https://jupyterlab.readthedocs.io/en/stable/user/interface.html
   - https://jupyterlab.readthedocs.io/en/stable/user/notebook.html

   Start a Jupyter Lab on your own computer, e.g. by entering `jupyter lab` in the virtual terminal.
   Create a new Python 3 notebook, enter the following two lines in the first code cell and execute it by clicking on the play button in the toolbar (or typing Shift+Enter):

   ```python
   import openmm.testInstallation
   openmm.testInstallation.main()
    ```

   This should show the same output as in the previous step.

   By default, the line numbers are not shown next to source code in Jupyter Lab, while such numbering is actually very convenient.
   The line numbers can be enabled permanently as follows.
   In the menu of Jupyter Lab, go to `Settings` > `Advanced Settings Editor`.
   From the list, select `Notebook` and put the following in the `User Preferences` panel:

   ```json
   {
       "codeCellConfig": {
           "lineNumbers": true,
       }
   }
   ```

   Finally, click on the :floppy_disk: icon on the top right of the `User Preferences` panel.

1. Install VMD, which will be used for showing some visualization good practices.
   Go to [the VMD download page](https://www.ks.uiuc.edu/Development/Download/download.cgi?PackageName=VMD) and follow instructions.
