# Setup of OpenMM and Jupyterlab on your laptop

To run OpenMM simulations on your laptop, we will work with a standardized Python environment, Anaconda, which is supported on all major operating systems.
For reasons of efficiency and robustness, we will in fact use a derivative of Anaconda, called Mambaforge.

:warning: **As of May 2022, the installation of OpenMM on Windows is broken.**
Technical details of this issue can be found below.
For now, Windows users are advised to run their calculations on a high-performance cluster (HPC), which typically runs on Linux.
As explained below, the Windows Subsytem for Linux may be a workaround, but it comes with yet other bugs, for which you need to apply workarounds.
Some of the Windows issues are fairly old and don't seem to get fixed in short term.
Most of the simulation software is developed for Unix platforms (macOS and Linux), and Windows is mainly an aftertought for most developers, which explains the poor support for Windows.


## Installation

Take the following steps:

1. Download the [Mambaforge installer](https://conda-forge.org/miniforge/)
   that matches the operating system and CPU architecture of your laptop.

1. Run the Mambaforge installer.

   - **Bare Windows.**
     Run the `.exe` installer.

   - **macOS, Linux and WSL.**
     Open a virtual terminal and enter the following command:
     ```bash
     bash Mambaforge*.sh -b -p ${HOME}/mambaforge
     ```
     Add the following line to your `~/.bashrc` file, which makes it convenient to activate the Mambaforge installation:
     ```bash
     alias m='eval "$(${HOME}/mambaforge/bin/conda shell.bash hook)"; source ${HOME}/mambaforge/etc/profile.d/mamba.sh'
     ```
     Close the terminal

1. Start a (new) virtual terminal.

   - **Bare Windows.**
     Run the application "Anaconda prompt" from the start menu.

   - **macOS.**
     Click on the terminal icon in the dock and enter the command alias `m`.

   - **Linux and WSL.**
     Open your preferred virtual terminal and enter the command alias `m`.

1. Configure Mambaforge and install OpenMM (and other useful tools).

   In this step, you all need to enter commands in a virtual terminal, the software equivalent of terminal computers from the 70s.
   Every command you enter will be executed after you press `Enter`.
   Possibly some output is shown as a result, but not always.
   Virtual terminals are powerful tools, but they are also picky!
   Almost every character or whitespace you type does matter.

   - **Bare Windows.**
     Copy the lines below **one by one** in the Anaconda prompt.
     Do not copy comment lines starting with a `#`.

   - **macOS, Linux and WSL.**
     Run the following commands in a virtual terminal.
     You can copy-paste all lines in one go.
     (Lines starting with `#` are comments and are ignored.)

   Commands to be entered:
   ```bash
   # Make sure your base environment is up-to-date.
   mamba update --all
   # Make a new environment for OpenMM, installing all the software, which takes some minutes.
   # The mamba create command is too long to fit on your screen.
   # Make sure you copy it completely.
   mamba create -n openmm python cudatoolkit git jupyterlab numpy pandas scipy matplotlib ipympl rdkit openbabel openmm mdtraj nglview pymbar pdbfixer parmed
   # Activate the OpenMM environment
   mamba activate openmm
   ```

   You may have to close your terminal and re-open a new one,
   run the commands `m` (Linux and macOS only) and `mamba activate openmm` again before the following steps work.

1. Test your OpenMM installation by entering the following command on the command prompt:

   ```bash
   python -m openmm.testInstallation
   ```

   You should see the following output (or something similar):

   ```
    OpenMM Version: 8.0
    Git Revision: a7800059645f4471f4b91c21e742fe5aa4513cda

    There are 2 Platforms available:

    1 Reference - Successfully computed forces
    2 CPU - Successfully computed forces

    Median difference in forces between platforms:

    Reference vs. CPU: 6.2963e-06

    All differences are within tolerance.
   ```

1. For **WSL** only: you need to install the IPython kernel of the `openmm` environment, before you can use it in Jupyter Notebooks.
   (It is not clear yet why this is needed, probably another WSL-specific bug.)
   You can install the kernel with the following command:

   ```bash
   python -m ipykernel install --user --name=openmm
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

To start any notebook from the tutorial, download [the ZIP file with the most recent notebooks](https://github.com/molmod/openmm-tutorial-msbs/archive/main.zip) and unzip this archive.

- On **Windows** open a Conda prompt and change the directory to where you unzipped the archive.
  If needed, first change to the correct drive, e.g. by typing the command `D:`, then use e.g. `cd` followed by the name of the directory where the ZIP file was unpacked.

- On **macOS, Linux or WSL**, open any terminal emulator and activate the mamba base environment:
  ```bash
  m
  ```
  Then change the directory to where you unzipped the archive.
  There is no need to change drives and the usage of `cd` is similar to Windows.

Once you have the right *current directory* in your virtual terminal, enter the following commands:

```bash
mamba activate openmm
jupyter lab
```

- On **Windows, macOS and Linux**, a browser window should pop up in which you can select and open a notebook.
- On **WSL**,

If you are not familiar with notebooks, the following resources can be helpful:
[Jupyter Lab Overview](https://jupyterlab.readthedocs.io/en/stable/getting_started/overview.html).

## Known issues

### Technical details of the problem when running OpenMM natively on Windows

Error message on Windows
```
(openmm) C:\Users\me>python -m openmm.testInstallation
Traceback (most recent call last):
File "C:\Users\me\mambaforge\envs\openmm\lib\runpy.py", line 188, in _run_module_as_main
mod_name, mod_spec, code = _get_module_details(mod_name, _Error)
File "C:\Users\me\mambaforge\envs\openmm\lib\runpy.py", line 111, in get_module_details
import(pkg_name)
File "C:\Users\me\mambaforge\envs\openmm\lib\site-packages\openmm_init.py", line 19, in
from openmm.openmm import *
File "C:\Users\me\mambaforge\envs\openmm\lib\site-packages\openmm\openmm.py", line 13, in
from . import _openmm
ImportError: DLL load failed while importing _openmm: The specified module could not be found.
```

References:
- https://github.com/openmm/openmm/issues/3618
- https://github.com/uibcdf/PyUnitWizard/issues/22


**Windows Subsystem for Linux (WSL) = Potential workaround for Windows users**

As of Windows 10, Microsoft distributes the Windows Subsystem for Linux (WSL).
This allows you to run Linux inside your Windows operating system, giving you access to a small-scale version the software environment used on the high-performance cluster.
More details can be found in the [Official WSL installation instructions](https://docs.microsoft.com/en-us/windows/wsl/install-win10).
For this course, WSL is optional and left to those interested in a little extra hacking.


## Docker-based environment

Docker is a virtualization tool (think of it as a virtual computer inside of your physical computer/laptop) that helps with creating a pre-defined working environment. The benefit of using this method is that it doesn't require going through the lengthy installation steps, and the whole process takes less than 10 mins to set up. The downside of this approach is that you may find the container abstraction confusing, but it's worthwhile to learn how docker works, as many modern software projects support this approach.

1. Install docker or podman on your machine

In order to use a docker image, you must first install Docker Desktop on your computer. Go to their [website](https://www.docker.com/products/docker-desktop/), and download the latest version compatible with your operating system e.g. MacOS.

Docker Desktop is free to use for individuals, but if you're working in an enterprise environment, consider using [podman](https://podman.io/docs/installation), which has a much more permissive license (Apache 2.0).

2. Download the container image and start a new container

From the repository run the following command:
```
./run_container.sh docker
```

n.b. replace `docker` with `podman` if you installed `podman` instead

It should download the container image (only the first time), and start a Jupyter Lab session from the container.

3. Copy the Jupyter Lab's URL from the command line output and paste it into the browser.

Look for the line that starts with `http://127.0.0.1:8888:lab?token=`. Copy the entire line and paste it into the browser, and you should be able to access the Jupyter Lab server and get started on the tutorial.
