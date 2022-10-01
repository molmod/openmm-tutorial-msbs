# Setup for interactive OpenMM Jupyter Notebooks on VSC clusters.

The VSC supercomputer center offers interactive sessions to run Jupyter notebooks directly on the cluster.
Unfortunately, this is only available for users with access to the VSC supercomputer center, although other calculation centers may offer similar features.
We do not offer support for that and as such, the following instructions are meant for people with access to the Flemish Supercomputer Center (VSC) (i.e. people affiliated to a Flemish research institution).

The exact procedure to request an account depends on your host institution.
Students at Ghent University can request a VSC account [here](https://www.ugent.be/hpc/en/access/policy/access#Students).

The following sections assume that you have access to the account and can log in to the page [login.hpc.ugent.be](https://login.hpc.ugent.be).


## Installation

Start by following the Installation instructions in [setup_on_a_hpc.md](setup_noninteractive_hpc.md), which are needed prior to the steps below.
Keep your virtual terminal open after following these installation instructions
If you did close it, start a new virtual terminal, and re-activate the OpenMM environment with the following two commands:

```bash
m
conda activate py39openmm
```


1. The following command adds the OpenMM environment to the list of available kernels for Jupyter.
   This new kernel can later be selected in the interactive Jupyter Notebook session.

   ```bash
   python -m ipykernel install --user --name=py39openmm
   ```

   Note that this only works when the original kernel and the new one run the same Python version.
   (Both 3.9 at the moment.)

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

1. Select a cluster and resources that you want to use.
   The more resources you require (hours, number of nodes and number of cores), the longer you will have to wait to get access to you session as there is a queue system in place (more information here: https://docs.vscentrum.be/en/latest/jobs/the_job_system_what_and_why.html).
   Normally, the following settings should ensure a near-immediate start of your session with workable resources for the notebooks in this tutorial:

   - **Cluster:** `slaking (interactive/debug)` (On this cluster, there is practically no queueing time.)
   - **Time (hours):** Fill in the time you will be working on the notebook.
     Your session will be killed when this time has passed.
   - **Number of nodes:** always `1` in this course.
   - **Number of cores:** normally always `1`, unless you use Python libraries that can exploit multiple cores (and know how to do this).
   - **IPython version:** `7.26.0 GCCcore 11.2.0`
   - **Custom code:** leave empty
   - **Extra Jupyter Arguments:** `--notebook-dir="/data/gent/4YY/vsc4YYXX"`, where `vsc4YYXX` should be replaced by your VSC ID, and `4YY` are just the first three digits of your VSC ID.
   - **Extra sbatch arguments:** leave empty
   - **I would like to receive an email when the session starts:** no need to check this.

   Most of these settings are already set correctly by default.

1. Scroll down and click the `Launch` button.
   A new screen will appear showing the status of your request (queueing or about to start).
   Normally, you should get the following:

   ```
   Your session is currently starting...
   Please be patient as this process can take a few minutes.
   ```

1. After some time a button will appear saying `Connect to Jupyter`, click it.
   A jupyter environment should open in a new tab.

1. On the right side of the page, there is a tab saying `New`, click it and select the environment that you created earlier.
   If you followed our instructions, it should be named `py39openmm`.

1. Enter the following two lines in the first code cell and execute it by clicking on the play button in the toolbar (or typing Shift+Enter):

   ```python
   import openmm.testInstallation
   openmm.testInstallation.main()
    ```

   This should show the same output as when you tested OpenMM in a virtual terminal.


## Running a Notebook from the tutorial.

Either use the running Notebook session from the previous section, or start a new one, by repeating the first 4 steps from the previous section.

1. Select and open a notebook of your choice.
   For example, to get started, open the notebook `01_first_steps/01_water.ipynb`.
   If you are not familiar with notebooks, the following resources can be helpful: [Jupyter Notebook Documentation](https://jupyter-notebook.readthedocs.io/en/latest/notebook.html).

1. After opening a notebook, click `Kernel` in the menu tabs and select `Change Kernel`.
   Choose the environment that was created previously.
   If you followed our instructions, it should be named `py39openmm`.
   This is needed to use the OpenMM environment that you created.

1. Now you should be able to run everything in the Notebook you just opened.
