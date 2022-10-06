**Disclaimer.**
This is a draft for new installation instructions on VSC. It will supersede the current `setup_interactive_vsc.md`.
Other documents can still be useful in their own right, but may need to be generalized to work more easily for non-VSC users.
Things to be done before this can be used:
- Request OpenMM-7.7 module installation + some extra's: up-to-date Python, matplotlib, pandas, scipy.
- Adapt instructions and `install_msbs_env.sh` for the newer versions.
- Ideally, we'd use also IPython and Jupyter installed on the cluster.
  It is not clear yet at this stage, how to make that work together with a venv containing extra Python packages.

# Setup for interactive OpenMM Jupyter Notebooks on VSC clusters.

The VSC supercomputer center offers interactive sessions to run Jupyter notebooks directly on the cluster.
Unfortunately, this is only available for users with access to the VSC supercomputer center, although other calculation centers may offer similar features.
We do not offer support for that and as such, the following instructions are meant for people with access to the Flemish Supercomputer Center (VSC) (i.e. people affiliated to a Flemish research institution).

The exact procedure to request an account depends on your host institution.
Students at Ghent University can request a VSC account [here](https://www.ugent.be/hpc/en/access/policy/access#Students).

The following sections assume that you have access to the account and can log in to the page [login.hpc.ugent.be](https://login.hpc.ugent.be).


## Installation of additional Python packages

We will use the OpenMM version that is already installed on the cluster, togehter with several other relevant Python packages.
However, some more Python packages are needed for the tutorial, which need to be installed in your home directory.

Take make this easier, we have prepared a job script `install_msbs_env.sh`, which can be submitted to any of the clusters, to prepare this software environment for you.
This job script can be used as follows.

1. Navigate to [login.hpc.ugent.be](https://login.hpc.ugent.be) and follow the steps to log in.

1. In the blue top bar click `Clusters` > `login Shell Access`.
   A new tab should open with a black screen and a welcome message from the HPC cluster,
   containing some information on the current state of the cluster.

1. Download the notebooks for the tutorials to the `$VSC_DATA` folder of your account so that you can access them at any time during the tutorial.
   This will also give you a copy of `install_msbs_env.sh` on the cluster.
   Execute the following commands in the virtual terminal.

   ```bash
   cd $VSC_DATA
   wget https://github.com/molmod/openmm-tutorial-msbs/archive/master.zip
   unzip master.zip
   ```

   This creates a directory `openmm-tutorial-msbs-master` with a copy of the latest version of this GitHub repository.

1. Submit installation job as follows:

   ```bash
   cd openmm-tutorial-msbs-master
   module swap cluster/slaking
   sbatch install_msbs_env.sh
   ```

   You can `module swap` to any other cluster to repeate the installation on different types of hardware.
   To cover all CPU architectures, run the following:

   ```bash
   module swap cluster/victini
   sbatch install_msbs_env.sh
   module swap cluster/joltik
   sbatch install_msbs_env.sh
   module swap cluster/doduo
   sbatch install_msbs_env.sh
   module swap cluster/accelgor
   sbatch install_msbs_env.sh
   ```

   Note that these four clusters are production machines, and your job may have to wait in the queue for a while (days even) before resources become available to run the install script.


## Test OpenMM in an Interactive Jupyter Notebook

1. You can now close the terminal as you do not need it for the remaining steps.
   Instead, go back to [login.hpc.ugent.be](https://login.hpc.ugent.be) and click on `Interactive Apps` > `Jupyter Notebook`.
   A new page should open.
   You may also use the experimental `Jupyter Lab` instead.

1. Select a cluster and resources that you want to use.
   The more resources you require (hours, number of nodes and number of cores), the longer you will have to wait to get access to you session as there is a queue system in place (more information here: https://docs.vscentrum.be/en/latest/jobs/the_job_system_what_and_why.html).
   Normally, the following settings should ensure a near-immediate start of your session with workable resources for the notebooks in this tutorial:

   - **Cluster:** `slaking (interactive/debug)` (On this cluster, there is practically no queueing time.)
   - **Time (hours):** Fill in the time you will be working on the notebook.
     Your session will be killed when this time has passed.
   - **Number of nodes:** always `1` in this course.
   - **Number of cores:** `2` (This may be useful for combining visualization and computation loads. Feel free to increase for heavier MD runs. OpenMM can efficiently use more.)
   - **IPython version:** pick something, does not matter
   - **Custom code:** fill in the following:
     ```bash
     module purge
     module load OpenMM/7.5.0-intel-2020b
     module load matplotlib/3.3.3-intel-2020b
     . ${VSC_DATA}/venvs/${VSC_ARCH_LOCAL}/3.8.6-GCCcore-10.2.0/bin/activate
     ```
   - **Extra Jupyter Arguments:** `--notebook-dir="${VSC_DATA}"`
   - **Extra sbatch arguments:** leave empty
   - **I would like to receive an email when the session starts:** no need to check this.

   Most of these settings are already correct by default.

1. Scroll down and click the `Launch` button.
   A new screen will appear showing the status of your request (queueing or about to start).
   Normally, you should get the following:

   ```
   Your session is currently starting... Please be patient as this process can take a few minutes.
   ```

1. After some time, a button will appear saying `Connect to Jupyter`.
   Click this button and a Jupyter Notebook (or Lab) should open in a new tab.

1. On the right side of the page, there is a tab saying `New`. Click it.

1. Enter the following two lines in the first code cell and execute it by clicking on the play button in the toolbar (or typing Shift+Enter):

   ```python
   import openmm.testInstallation
   openmm.testInstallation.main()
    ```

   This should show the same output as when you tested OpenMM in a virtual terminal.


## Running a Notebook from the tutorial.

Either use the running Notebook session from the previous section, or start a new one, by repeating the first 4 steps from the previous section.

1. Select and open a Notebook of your choice.
   For example, to get started, open the notebook `01_first_steps/01_water.ipynb`.

1. You should be able to run everything in the Notebook you just opened.

If you are not familiar with Jupyter Notebooks, the following resources can be helpful: [Jupyter Notebook Documentation](https://jupyter-notebook.readthedocs.io/en/latest/notebook.html).
