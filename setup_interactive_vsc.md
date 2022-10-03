# Setup for interactive OpenMM Jupyter Notebooks on VSC clusters.

The VSC supercomputer center offers interactive sessions to run Jupyter notebooks directly on the cluster.
Unfortunately, this is only available for users with access to the VSC supercomputer center, although other calculation centers may offer similar features.
We do not offer support for that and as such, the following instructions are meant for people with access to the Flemish Supercomputer Center (VSC) (i.e. people affiliated to a Flemish research institution).

The exact procedure to request an account depends on your host institution.
Students at Ghent University can request a VSC account [here](https://www.ugent.be/hpc/en/access/policy/access#Students).

The following sections assume that you have access to the account and can log in to the page [login.hpc.ugent.be](https://login.hpc.ugent.be).


## Installation part A: Jupyter Extensions, needed for visualization

1. Navigate to [login.hpc.ugent.be](https://login.hpc.ugent.be) and follow the steps to log in.

1. In the blue top bar click `Clusters` > `login Shell Access`.
   A new tab should open with a black screen and a welcome message from the HPC cluster,
   containing some information on the current state of the cluster.

1. Load the IPython module that will be used to run Interactive Jupyter Notebooks, by entering the following command:

   ```bash
   ml load IPython/7.26.0-GCCcore-11.2.0
   ```

   The following steps will install Jupyter extensions on top of this module,
   which will be used for visualization and other purposes.

1. Install the latest version of `pip`:

   ```bash
   pip install --upgrade pip
   ```

1. Install the Python packages of the extensions:

   ```bash
   pip install nglview jupyter_contrib_nbextensions
   ```

1. You may see some warnings related to the `PATH` variable.
   These can be fixed by editing `.bashrc` with `nano`.
   Execute the following command:

   ```bash
   nano ~/.bashrc
   ```

   This is a simple text editor.
   Go with the arrow keys to the last line and add the following:

   ```bash
   export PATH="${HOME}/.local/bin:${PATH}"
   ```

   Save the file and close `nano` with the key combination `Ctrl-x` and follow instructions on screen.

   Close the virtual terminal by entering the `exit` command and open a new virtual terminal.
   Activate the IPython module again before continuing with the following steps:

   ```bash
   ml load IPython/7.26.0-GCCcore-11.2.0
   ```

1. Activate the Jupyter extensions with the following commands.

   ```bash
   jupyter contrib nbextension install --user
   jupyter nbextension enable spellchecker/main
   jupyter nbextension enable widgetsnbextension --user --py
   jupyter nbextension enable nglview --py
   ```

**Note.** If you somehow made a mistake, or have remnants from previous attempts for some other reason, it may help to clean these up.
:warning:
The following is rather invasive and may remove more than you want.
**When in doubt, don't do this, and ask for help instead**:
`rm -rf ~/.local/* ~/.ipython/ ~/.jupyter/`.


## Installation part B: OpenMM

Follow the installation instructions in [setup_noninteractive_hpc.md](setup_noninteractive_hpc.md).
(The test job submission can be skipped.)

## Installation part C: Final steps


1. Start a new virtual terminal on the HPC, e.g. through [login.hpc.ugent.be](https://login.hpc.ugent.be).
   Load the Python version in which the Jupyter Notebooks will be executed,
   and activate the OpenMM environment:

   ```bash
   ml load IPython/7.26.0-GCCcore-11.2.0
   m
   conda activate py39openmm
   ```

1. The following command adds the OpenMM environment to the list of available kernels for Jupyter.
   This new kernel can later be selected in the interactive Jupyter Notebook session.

   ```bash
   python -m ipykernel install --user --name=py39openmm
   ```

   This will configure a new kernel in `~/.local/share/jupyter/kernels/python3/py39openmm`.
   If you ever want to uninstall this kernel, you can just remove that directory.

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
   You may also use the experimental `Jupyter Lab` instead.

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

1. After some time, a button will appear saying `Connect to Jupyter`.
   Click this button and a Jupyter Notebook (or Lab) should open in a new tab.

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

1. Select and open a Notebook of your choice.
   For example, to get started, open the notebook `01_first_steps/01_water.ipynb`.
   If you are not familiar with Jupyter Notebooks, the following resources can be helpful: [Jupyter Notebook Documentation](https://jupyter-notebook.readthedocs.io/en/latest/notebook.html).

1. After opening a Notebook, click `Kernel` in the menu tabs and select `Change Kernel`.
   Choose the environment that was created previously.
   If you followed our instructions, it should be named `py39openmm`.

1. Now you should be able to run everything in the Notebook you just opened.
