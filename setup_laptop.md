# Setup of OpenMM and Jupyterlab on your laptop

To run OpenMM simulations on your laptop, we will work with a standardized Python environment, Anaconda, which is supported on all major operating systems.
For reasons of efficiency and robustness, we will in fact use a derivative of Anaconda, called Mamba-forge.

Some of the more specialized packages (required for tutorial `07_ligands`) are only used on Unix systems (Linux and macOS) by researchers in the field, and these have poor support on Windows.
Luckily, on Windows 10, Microsoft distributes the Windows Subsystem for Linux 2 (WSL2), as of a May 2019.
This allows you to run Linux inside your Windows operating system, giving you access to a small-scale version the software environment used on the high-performance cluster.
More details can be found in the [Official WSL installation instructions](https://docs.microsoft.com/en-us/windows/wsl/install-win10).
For this course, WSL2 is optional and left to those interested in a little extra hacking.

:warning: **As of May 2022, installation of OpenMM on Windows seems broken.**


## Installation

Take the following steps:

1. Download the [Mamba-forge installer](https://github.com/conda-forge/miniforge#mambaforge)
   that matches the operating system and CPU architecture of your laptop.

1. Run the Anaconda Python installer.

   **Windows.**
   Run the `.exe` installer.

   **macOS.** and **Linux.**
   Open a virtual terminal and enter the following command:
   ```bash
   bash Mambaforge*-sh -b -p ${HOME}/mambaforge
   ```
   Add the following line to your `~/.bashrc` file, which makes it convenient to activate the conda installation:
   ```bash
   alias m='eval "$(/home/toon/mambaforge/bin/conda shell.bash hook)"'
   ```
   Close the terminal

1. Start a (new) virtual terminal.

   **Windows.**
   Run the application "Anaconda prompt" from the start menu.

   **macOS.**
   Click on the terminal icon in the dock and enter the command alias `m`.

   **Linux.**
   Open your preferred virtual terminal and enter the command alias `m`.

1. Configure conda and install OpenMM (and other useful tools).

   In this step, you all need to enter commands in a virtual terminal, the software equivalent of terminal computers from the 70s.
   Every command you enter will be executed after you press `Enter`.
   Possibly some output is shown as a result, but not always.
   Virtual terminals are powerful tools, but they are also picky!
   Almost every character or whitespace you type does matter.

   **Windows.**
   Copy the following lines **one by one** in the anaconda terminal.
   Do not copy comment lines starting with a `#`.

   **macOS** or **Linux.**
   Run the following commands in a virtual terminal.
   You can copy-paste all lines in one go.
   (Lines starting with `#` are comments and are ignored.)

   ```bash
   # Make sure your base environment is up-to-date.
   mamba update --all
   # Make a new environment for OpenMM and activate it.
   # This will take a while.
   mamba create -n py39openmm python=3.9 cudatoolkit git jupyterlab numpy pandas scipy matplotlib ipympl rdkit openbabel openmm mdtraj nglview pymbar pdbfixer parmed jupyter_contrib_nbextensions
   conda activate py39openmm
   # Enable nglview and spell checker in jupyter notebooks.
   jupyter nbextension enable spellchecker/main
   jupyter nbextension enable nglview --py --sys-prefix
   ```

   You may have to close your terminal and re-open a new one,
   run `m` and `conda activate openmm` again before the following steps work.

1. Test your OpenMM installation by entering the following command on the command prompt:

   ```bash
   python -m openmm.testInstallation
   ```

   You should see the following output (or something similar):

   ```
   OpenMM Version: 7.7
   Git Revision: 130124a3f9277b054ec40927360a6ad20c8f5fa6

   There are 2 Platforms available:

   1 Reference - Successfully computed forces
   2 CPU - Successfully computed forces

   Median difference in forces between platforms:

   Reference vs. CPU: 6.30535e-06

   All differences are within tolerance.
   ```

1. Now is a good time to become more familiar with Jupyter Lab. The following link provide easy-to-follow guides, which will get you up to speed:

   - https://jupyterlab.readthedocs.io/en/stable/user/interface.html
   - https://jupyterlab.readthedocs.io/en/stable/user/notebook.html

   Start Jupyter Lab on your own computer, e.g. by entering `jupyter lab` in the virtual terminal.
   Create a new Python 3 notebook, enter the following two lines in the first code cell and execute it by clicking on the play button in the toolbar (or typing Shift+Enter):

   ```python
   import openmm.testInstallation
   openmm.testInstallation.main()
    ```

   This should show the same output as in the previous step.

1. By default, line numbers are not shown next to source code in Jupyter Lab, while such numbering is actually convenient.
   The line numbers can be enabled permanently as follows.
   In the menu of Jupyter Lab, go to `Settings` > `Advanced Settings Editor`.
   From the list, select `Notebook` and check the box next to `Show Line Numbers`.

1. Install VMD, which will be used for showing some visualization good practices.
   Go to [the VMD download page](https://www.ks.uiuc.edu/Development/Download/download.cgi?PackageName=VMD) and follow instructions.


## Usage

To start any notebook from the tutorial, download [the ZIP file with the most recent notebooks](https://github.com/molmod/openmm-tutorial-msbs/archive/master.zip) and unzip this archive.

- On **Windows** open a Conda prompt and change the directory to where you unzipped the archive.
  If needed, first change to the correct drive, e.g. by typing the command `D:`, then use e.g. `cd` followed by the name of the directory where the ZIP file was unpacked.

- On **macOS or Linux**, open any terminal emulator and activate the mamba base environment:
  ```bash
  m
  ```
  Then change the directory to where you unzipped the archive.
  There is no need to change drives and the usage of `cd` is similar to Windows.

Once you have the right *current directory* in your virtual terminal, enter the following commands:

```bash
conda activate py39openmm
jupyter lab
```

A browser window should pop up in which you can select and open a notebook. If
you are not familiar with notebooks, the following resources can be helpful:
[Jupyter Lab Overview](https://jupyterlab.readthedocs.io/en/stable/getting_started/overview.html).
