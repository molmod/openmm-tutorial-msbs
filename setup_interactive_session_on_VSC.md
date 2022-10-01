# Install OpenMM in an HPC environment for interactive use on VSC.

Working with an HPC requires a basic knowledge of the Linux operating system. If you have never used Linux before, this will be rich learning experience. Still, it is worth the trouble, because in a computational research lab, any serious simulation is performed on an HPC. Calculations on your laptop are only useful for teaching, preparing simulations or initial prototyping.

The VSC supercomputer center offers interactive sessions to run Jupyter notebooks directly on the cluster. Unfortunately, this is only available for users with access to the VSC supercomputer center, although other calculation centers may offer similar features. We do not offer support for that and as such, the following instructions are meant for people with access to the Flemish Supercomputer Center (VSC) (i.e. people affiliated to a Flemish research institution). The exact procedure to request an account depends on your host institution, students at Ghent University can [create a VSC account here](request_vsc_account_ugent.md).

The following sections assume that you have access to the account and can log in to the page [login.hpc.ugent.be](https://login.hpc.ugent.be).

## Installation

1. Navigate to [login.hpc.ugent.be](https://login.hpc.ugent.be) and follow the needed steps to log in.

1. From the blue top bar click `Clusters` > `login Shell Access`.
   A new tab should open with a black screen and a welcome message from the HPC cluster, containing some information on the current state of the cluster.

1. This would be a good time to go through [the Linux and HPC tutorials](https://www.ugent.be/hpc/en/support/documentation.htm).

1. After connecting to the HPC, determine a suitable location to install Minoconda.
   This is a slimmed-down version of Anaconda, which is suitable for non-local installations.
   The data directory should have sufficient quota (several Gigabytes) to contain the OpenMM installation.
   On the VSC clusters, this directory would be `$VSC_DATA`, but if you are working on another HPC, this might be different.
   In the instructions below, we will use `$VSC_DATA`, but this can be easily replaced.

1. The installation of OpenMM takes several steps. First download and install Miniconda.

   ```bash
   cd $VSC_DATA
   wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
   bash Miniconda3-latest-Linux-x86_64.sh -bfp ${VSC_DATA}/miniconda
   nano ~/.bashrc
   ```

   The last line will open a text editor in which the file `~/.bashrc` is opened. Add the following line to this file, save and close:

   ```bash
   alias c="source ${VSC_DATA}/miniconda/bin/activate"
   ```

   Now we can install OpenMM into the conda environment:

   ```bash
   # The following line loads the ~/.bashrc file you just adapted
   source ~/.bashrc
   c
   # Make sure your base environment is up-to-date.
   conda update --all
   # Make a new conda environment for OpenMM and activate conda-forge.
   conda create -n openmm python
   conda activate openmm
   conda config --env --add channels conda-forge
   conda config --env --set channel_priority strict
   conda update --all
   # The following install several packages in the openmm environment.
   # This will take a while!
   conda install cudatoolkit git jupyterlab numpy pandas scipy matplotlib ipympl rdkit openbabel openmm mdtraj nglview pymbar pdbfixer parmed jupyter_contrib_nbextensions
   # Enable nglview and spell checker in jupyter notebooks
   jupyter nbextension enable spellchecker/main
   jupyter nbextension enable nglview --py --sys-prefix
   ```

1. Run the following command to test the OpenMM software:

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

1. The following command adds the just created environment to the list of available kernels for Jupyter, so that it becomes available within the interactive Jupyter notebook session.

   ```bash
   python -m ipykernel install --user --name=openmm
   ```

1. Download the notebooks for the tutorials to the home folder of your account so that you can access them through the interactive Jupyter session later.

   ```bash
   cd $VSC_HOME
   wget https://github.com/molmod/openmm-tutorial-msbs/archive/master.zip
   unzip master.zip
   ```

   A folder should be created containing all the documents for the remainder of the tutorial.

**Note for Windows users:** Be aware that when connected to the HPC, you are working in a Linux environment even if you connect from your Windows PC. So follow Linux instructions where needed throughout the tutorial any time you are connected to the HPC.


## Testing OpenMM in Interactive Jupyter Notebooks

1. You can now close the terminal as you do not need it for the remainder of the tutorial. Instead, go back to [login.hpc.ugent.be](https://login.hpc.ugent.be) and click on `Interactive Apps` > `Jupyter Notebook`.
   A new page should open.

1. Select a cluster and resources that you want to use.
   The more resources you require (hours, number of nodes and number of cores), the longer you will have to wait to get access to you session as there is a queue system in place (more information here: https://docs.vscentrum.be/en/latest/jobs/the_job_system_what_and_why.html).
   Normally, the following settings should ensure a near-immediate start of your session with workable resources for the notebooks in this tutorial:

   - **Cluster:** `slaking (interactive/debug)` (On this cluster, there is practically no queueing time.)
   - **Time (hours):** Fill in the time you will be working on the notebook.
     Your session will be killed when this time has passed.
   - **Number of nodes:** always `1` in this course.
   - **Number of cores:** normally always `1`, unless you use Python libraries that can exploit multiple cores (and know how to do this).
   - **IPython version:** `7.15.0 foss 2020a Python 3.8.2`
   - **Custom code:** leave empty
   - **Extra Jupyter Arguments:** `--notebook-dir="/data/gent/4YY/vsc4YYXX"`, where `vsc4YYXX` should be replaced by your VSC ID, and `4YY` are just the first three digits of your VSC ID.
   - **Extra sbatch arguments:** leave empty
   - **I would like to receive an email when the session starts:** no need to check this.

   Some of these settings may already be set correctly by default.

1. Scroll down and click the `Launch` button.
   A new screen will appear showing you whether you are in the queue or whether the session is about to start
   (`Your session is currently starting... Please be patient as this process can take a few minutes.`).

1. After some time a button will appear saying `Connect to Jupyter`, click it.
   A jupyter environment should open in a new tab.

1. On the right side of the page, there is a tab saying `New`, click it and select the environment that you created earlier (by default, this was openmm).

1. Enter the following two lines in the first code cell and execute it by clicking on the play button in the toolbar (or typing Shift+Enter):

   ```python
   import openmm.testInstallation
   openmm.testInstallation.main()
    ```

   This should show the same output as when you tested OpenMM in a virtual terminal.


## Running a Notebook from the tutorial.

Either use the running Notebook session from the previous sessions, or start u new one, by repeating the first 4 steps from the previous section.

1. Select and open a notebook of your choice.
   For example, to get started, open the notebook `01_first_steps/01_water.ipynb`.
   If you are not familiar with notebooks, the following resources can be helpful: [Jupyter Notebook Documentation](https://jupyter-notebook.readthedocs.io/en/latest/notebook.html).

1. After opening a notebook, click `Kernel` in the menu tabs and select `Change Kernel`.
   Choose the environment that was created previously (if you followed the tutorial, this will be: `Python 3 openmm`).
   This is needed to use the packages that were installed in the conda environment that you created.

1. Now you should be able to run everything in the Notebook you just opened.
