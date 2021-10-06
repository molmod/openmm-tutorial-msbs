# Install OpenMM in an HPC environment for interactive use on VSC.

Working with an HPC requires a basic knowledge of the Linux operating system. If you have never used Linux before, this will be rich learning experience. Still, it is worth the trouble, because in a computational  research lab, any serious simulation is performed on an HPC. Calculations on your laptop are only useful for teaching, preparing simulations or initial prototyping. 

The VSC supercomputer center offers interactive sessions to run Jupyter notebooks directly on the cluster. Unfortunately, this is only available for users with access to the VSC supercomputer center, although other calculation centers may offer similar features. We do not offer support for that and as such, the following instructions are meant for people with access to the Flemish Supercomputer Center (VSC) (i.e. people affiliated to a Flemish research institution). The exact procedure to request an account depends on your host institution, students at Ghent University can [create a VSC account here](request_vsc_account_ugent.md). 

The following assumes that you have access to the account and are able to log in to the page https://login.hpc.ugent.be

1. Navigate to https://login.hpc.ugent.be and follow the needed steps to log in.

2. From the menu bar click 'clusters' > 'login Shell Access'. A new tab should open with a black screen and a welcome message from the HPC cluster, containing some information on the current state of the cluster.

3. This would be a good time to go through the Linux and HPC tutorials here: https://www.ugent.be/hpc/en/support/documentation.htm.

4. After connecting to the HPC, determine a suitable location to install Minoconda. This is a slimmed-down version of Anaconda, which is suitable for non-local installations. The data directory should have sufficient quota (several Gigabytes) to contain the OpenMM installation. On the VSC clusters, this directory would be `$VSC_DATA`, but if you are working on another HPC, this might be different. In the instructions below, we will use `$VSC_DATA`, but this can be easily replaced.

5. The installation of OpenMM takes several steps. First download and install Miniconda.

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
   conda config --add channels conda-forge
   # The following creates a conda environment called openmm
   # in which a several packages are installed.
   conda create -n openmm cudatoolkit=10.0 git jupyterlab numpy pandas scipy matplotlib ipympl rdkit openbabel openmm mdtraj nglview pymbar pdbfixer parmed openff-toolkit          openmoltools openmmforcefields
   # Activate the environment just created.
   conda activate openmm
   # Enable nglview in jupyter notebooks
   jupyter-nbextension enable nglview --py --sys-prefix
   ```

6. Run the following command to test the OpenMM software:

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

7. The following command adds the just created environment to the list of available kernels for Jupyter, so that it becomes available within the interactive Jupyter notebook session.

   ```bash
   python -m ipykernel install --user --name=openmm
   ```

8. Download the the notebooks for the turorials to the home folder of your account so that you can access them through the interactive jupyter session later on.

   ```bash
   cd $VSC_HOME
   wget https://github.com/molmod/openmm-tutorial-msbs/archive/master.zip
   unzip master.zip
   ```

   A folder should be created containing all the documents for the remainder of the tutorial.

9. You can now close the terminal as you do not need it for the remainder of the tutorial. Instead, go back to https://login.hpc.ugent.be and click on the tab 'Interactive Apps' > 'Jupyter Notebook'. A new page should open.

10. Select a cluster and resources that you want to use. The more resources you require (hours, number of nodes and number of cores), the longer you will have to wait to get access to you session as there is a queue system in place (more information here: https://docs.vscentrum.be/en/latest/jobs/the_job_system_what_and_why.html). Normally, the use of following settings should ensure a near-immediate start of your session with workable resources for the notebooks in this tutorial:

    - cluster = victini
    - Time = 4 (hours)    (be aware that the session will finish after the requested time without warning and you may lose progress)
    - nodes = 1
    - cores = 2

    The remaining settings do not need changing.

11. Click start session and a new screen will appear showing you whether you are in the queue or whether the session is about to start ('Your session is currently starting... Please be patient as this process can take a few minutes.').

12. After some time a button will appear saying 'Connect to Jupyter', click it. A Jupyter environment should open in a new tab.

13. On the right side of the page, there is a tab saying 'New', click it and select the environment that you created earlier (by default, this was openmm).

14. Now is a good time to become more familiar with Jupyter Lab. The following link provide easy-to-follow guides, which will get you up to speed:

   - https://jupyterlab.readthedocs.io/en/stable/user/interface.html
   - https://jupyterlab.readthedocs.io/en/stable/user/notebook.html

   Start a Jupyter Lab on the HPC as described in the previous step. Enter the following two lines in the first code cell and execute it by clicking on the play button in the      toolbar (or typing Shift+Enter):

   ```python
   import openmm.testInstallation
   openmm.testInstallation.main()
    ```

   This should show the same output as in step 7.

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

15. For Windows users: Be aware that when connected to the HPC, you are working in a Linux environment even if you connect from your Windows PC. So follow Linux instructions where needed throughout the tutorial any time you are connected to the HPC.
