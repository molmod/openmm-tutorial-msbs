# Setup for interactive OpenMM Jupyter Notebooks on VSC clusters.

The VSC supercomputer center offers interactive sessions to run Jupyter notebooks directly on the cluster.
Unfortunately, this is only available for users with access to the VSC supercomputer center, although other calculation centers may offer similar features.
We do not offer support for that and as such, the following instructions are meant for people with access to the Flemish Supercomputer Center (VSC) (i.e. people affiliated to a Flemish research institution).

The exact procedure to request an account depends on your host institution.
Students at Ghent University can request a VSC account [here](https://www.ugent.be/hpc/en/access/policy/access#Students).

The following sections assume that you have access to the account and can log in to the page [login.hpc.ugent.be](https://login.hpc.ugent.be).


## Installation part A: OpenMM

Follow the installation instructions in [setup_noninteractive_hpc.md](setup_noninteractive_hpc.md).
(The test job submission can be skipped.)

## Installation part B: Final steps


1. Start a new virtual terminal on the HPC, e.g. through [login.hpc.ugent.be](https://login.hpc.ugent.be).

1. Download the notebooks for the tutorials to the `$VSC_DATA` folder of your account so that you can access them through the interactive Jupyter session later.

   ```bash
   cd $VSC_DATA
   wget https://github.com/molmod/openmm-tutorial-msbs/archive/master.zip
   unzip master.zip
   ```

   A folder should be created containing all the documents for the remainder of the tutorial.


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
   - **Number of cores:** normally always `1`, unless you use Python libraries that can exploit multiple cores (and know how to do this).
   - **IPython version:** pick something, does not matter
   - **Custom code:** fill in the following:
     ```bash
     module purge
     eval "$(${VSC_DATA}/mambaforge/bin/conda shell.bash hook)"
     conda activate py39openmm
     ```
   - **Extra Jupyter Arguments:** `--notebook-dir="${VSC_DATA}"`
   - **Extra sbatch arguments:** leave empty
   - **I would like to receive an email when the session starts:** no need to check this.

   Most of these settings are already set correctly by default.

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
