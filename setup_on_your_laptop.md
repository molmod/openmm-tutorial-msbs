# Installation of OpenMM on your laptop

To run OpenMM simulations on your laptop, we will work with a standardized Python environment, Anaconda, which is supported on all major operating systems.

Take the following steps:

1. Download the Anaconda Python 3.7 installer for your operating system. The 64-bit version is strongly preferred if your hardware and operating system support it. (Most modern laptops do.) The installer can be downloaded from [the anaconda website](https://www.anaconda.com/distribution/).

2. Run the Anaconda Python installer.

    a. Windows: open the `.exe` file.

    b. MacOS: ???

    c. Linux: run `./Anaconda3-*-Linux-x86_64.sh -b -p ${HOME}/anaconda`.
       Add the following line to your `~.bashrc` file, which makes it convenient to
       activate the conda installation:
       `alias c='source ~/anaconda/bin/activate'`.

3. Start a command-line prompt.

    a. Windows: run the application "Anaconda prompt" from the start menu.

    b. MacOS: ???

    c. Linux: open your preferred terminal emulator and enter the command alias `c`.


4. Configure conda and install OpenMM and other useful tools) by running the following commands. Copy-paste should work, but on Windows you have to copy-paste line by line. (You can skip the comments.)

    ```bash
    conda config --add channels conda-forge
    # The following creates a conda environment called openmm
    # in which a several packages are installed.
    conda create -n openmm spyder jupyter numpy pandas scipy matplotlib ipympl rdkit openbabel
    # activate the environment just created.
    conda activate openmm
    # install openmm and a few more related tools.
    conda install -c omnia openmm mdtraj nglview openforcefield
    jupyter-nbextension enable nglview --py --sys-prefix
    ```


5. Test your OpenMM installation by entering the following command on the command prompt:

    ```bash
    python -m simtk.testInstallation
    ```

    You should see the following output (or something similar):

    ```
    OpenMM Version: 7.4
    Git Revision: b71e92d9ccef7c98cfd6b862eb34095d94fa1b05

    There are 3 Platforms available:

    1 Reference - Successfully computed forces
    2 CPU - Successfully computed forces
    3 OpenCL - Error computing forces with OpenCL platform

    OpenCL platform error: Error initializing context: clGetDeviceIDs (-1)

    Median difference in forces between platforms:

    Reference vs. CPU: 6.31232e-06

    All differences are within tolerance.
    ```


6. Now is a good time to go through the [Jupyter Notebook Introduction](https://jupyter-notebook.readthedocs.io/en/stable/notebook.html#starting-the-notebook-server) to become familiar with its main features.

    Start a Jupyeter notebook, e.g. by entering `jupyter notebook` in the command-prompt. Create a new Python 3 notebook, enter the following two lines in the first code cell and execute it by clicking on the play button (or typing Shift+Enter):

    ```python
    import simtk.testInstallation
    simtk.testInstallation.main()
    ```

    If you get a "kernel error" on Windows, you might be running into the following issue (or a similar one): https://github.com/jupyter/notebook/issues/4907. this should be in principle solved with the `jupyter_client>=5.3.4` and `jupyter_core>=4.6.1`, available on conda-forge as of November 17, 2019. In case you still run into this issue, try to downgrade `jupyter_client` to version 5.3.1 as follows on your Conda prompt:

    ```
    conda install jupyter_client=5.3.1
    ```


7. Start Spyder, a simple Python integrated development environment, enter the same two lines from the previous point in the editor and execute (click the green Play button). You should see the same output. Unlike notebooks, source code in Spyder is not grouped into cells. Unlike notebooks, a script in Spyder does not know remember variables from previous executions.


8. Install VMD, which will be used for showing some visualization good practices.

   a. Any operating system: go to [the VMD download page](https://www.ks.uiuc.edu/Development/Download/download.cgi?PackageName=VMD) and follow instructions.

   b. On Linux, the following also works but might not be fully legal:

      ```
      # We'll also install VMD, in a separate conda environment
      # because it seems to interfere with jupyter notebooks.
      conda create -n vmd vmd
      # To start VMD, switch conda to the conda environment and start
      # VMD.
      conda activate vmd
      vmd
      ```
