# Setup on VSC clusters

The [Flemish Supercomputer Center (VSC)](https://www.vscentrum.be/) offers interactive sessions to run Jupyter notebooks directly on the cluster.
The instructions below are written for students and researchers affiliated with on of the Flemish universities, and it is assumed that you are using the Tier-2 cluster at Ghent University, to which all VSC users have access.

For those without VSC access, we also have [a more generic setup for high-performance clusters](setup_hpc.md).

If you are affiliated with a Flemish University, but don't have a VSC yet, you need to request one first.
The exact procedure depends on your host institution.
Students and researchers at Ghent University can request a VSC account [here](https://www.ugent.be/hpc/en/access/policy/access).

The following sections assume that you have access to your VSC account and can log in to the page [login.hpc.ugent.be](https://login.hpc.ugent.be).


## Installation of additional Python packages

We will use the OpenMM and several other Python packages, which are already installed on the cluster.
In addition, some more Python packages are needed for the tutorial, which need to be installed in your account.

Take make this easier, we prepared a job script `job_install_vsc.sh`, which can be submitted to any VSC cluster, to prepare this software environment for you.
You can use this job script as follows.

1. Navigate to [login.hpc.ugent.be](https://login.hpc.ugent.be) and follow the steps to log in.

1. In the blue top bar, click `Clusters` > `>_ RHEL9 Login node Shell Access`.
   A new tab should open with a black screen and a welcome message from the HPC cluster,
   containing some information on the current state of the cluster.

1. Prepare a working directory for the course under `$VSC_DATA` by
   entering the following commands:

   ```bash
   cd $VSC_DATA
   mkdir msbs
   cd msbs
   ```

1. Download the notebooks for the tutorials to the `$VSC_DATA/msbs` folder of your account
   so that you can access them at any time during the tutorial.
   This will also give you a copy of `job_install_vsc.sh` on the cluster.
   Execute the following commands in the virtual terminal.

   ```bash
   git clone https://github.com/molmod/openmm-tutorial-msbs.git
   ```

   This creates a directory `openmm-tutorial-msbs` with a copy of the latest version of the tutorial.
   Enter the `setup` directory under `openmm-tutorial-msbs`:

   ```bash
   cd openmm-tutorial-msbs/setup
   ```

1. Submit the installation job as follows:

   ```bash
   module swap cluster/donphan
   sbatch job_install_vsc.sh
   ```

1. Optionally, if you have sufficient storage on your `$VSC_DATA` partition, which is not the case for most students,
   you can `module swap` to any other cluster to repeat the installation on different types of hardware.
   To cover all CPU architectures, run the following:

   ```bash
   module swap cluster/doduo
   sbatch job_install_vsc.sh
   module swap cluster/joltik
   sbatch job_install_vsc.sh
   module swap cluster/accelgor
   sbatch job_install_vsc.sh
   ```

   Note that these four clusters are production machines, and your job may have to wait in the queue for a while (days even) before resources become available to run the install script.


## Test OpenMM in an Interactive Jupyter Notebook

1. You can now close the terminal, as it is no longer needed.
   Instead, go back to [login.hpc.ugent.be](https://login.hpc.ugent.be)
   and click on `Interactive Apps` > `Jupyter Lab`.
   A new page should open.

1. Select a cluster and the resources that you want to use.
   The more resources you request (hours, number of nodes and number of cores),
   the longer you will have to wait to get access to you session.

   - **Cluster:** `donphan (interactive/debug)` (On this cluster, there is practically no queuing time.)
   - **Time (hours):** Fill in the time you will be working on the notebook.
     Your session will be killed when this time has passed.
   - **Number of nodes:** always `1` in this course.
   - **Number of cores per node:** `2`
     (This may be useful for combining visualization and computation loads.
     OpenMM can efficiently use multiple CPU cores.
     Feel free to increase for heavier MD runs,
     but keep in mind that you can used at most eight cores on donphas,
     summed over all running jobs.)
   - **JupyterLab version:** `None (advanced)`
   - **Custom code:**
       ```bash
       source ${VSC_DATA}/msbs/venvs/activate.sh
       ```
   - **Extra Jupyter Arguments:**
       ```bash
       --notebook-dir="${VSC_DATA}/msbs/openmm-tutorial-msbs"
       ```
   - **Reservation id:** none
   - **Extra qsub arguments:** leave empty
   - **I would like to receive an email when the session starts:** no need to check this.
   - **Show advanced options:** yes.

   In the advanced options, select 120 seconds for the timeout.

   Most of these settings are already correct by default.

1. Scroll down and click the blue `Launch` button.

   Your job is placed in a queue and will only start when the requested resources become available.
   (More information here: https://docs.vscentrum.be/en/latest/jobs/the_job_system_what_and_why.html).
   Normally, the above settings should ensure a near-immediate start of your session
   with workable resources for the notebooks in this tutorial.

   A new screen will appear showing the status of your request (queuing or about to start).
   Normally, you should get the following:

   ```
   Your session is currently starting... Please be patient as this process can take a few minutes.
   ```

1. After a few seconds, a green button will appear saying `Connect to Jupyter Lab`.
   Click this button and a Jupyter Lab should open in a new tab.

1. In the `Launcher` tab, under `Notebook`, click on `Python 3 (ipykernel)`.
   A new notebook should open.

1. Enter the following two lines in the first code cell and execute it
   by clicking on the play button in the toolbar (or typing Shift+Enter):

   ```python
   import openmm.testInstallation
   openmm.testInstallation.main()
   ```

   You should see the following output (or something similar):

   ```
   OpenMM Version: 8.0
   Git Revision: Unknown

   There are 2 Platforms available:

   1 Reference - Successfully computed forces
   2 CPU - Successfully computed forces

   Median difference in forces between platforms:

   Reference vs. CPU: 6.29574e-06

   All differences are within tolerance.
   ```


## Running a Notebook from the tutorial.

Either use the running Jupyter Lab session from the previous section,
or start a new one, by repeating the first 4 steps from the previous section.

1. Select and open a Notebook of your choice.
   For example, to get started, find and open the notebook
   `openmm-tutorial-msbs/01_first_steps/01_water.ipynb`.

1. You should be able to run everything in the Notebook you just opened.

   If you are not familiar with Jupyter Notebooks, the following resources can be helpful [Jupyter Notebook Documentation](https://jupyter-notebook.readthedocs.io/en/latest/notebook.html).

1. Stop Jupyter Lab:
    - Click on `File` (in Jupyter Lab, not your browser), then `Shutdown` and then confirm.
    - On `login.hpc.ugent.be`, the job will be marked as completed.
      You can safely delete it.


## GPU Acceleration

:warning: This section is outdated. It is no longer compatible with the version of OpenMM installed at VSC.

In the [Tier-2 infrastructure](https://www.ugent.be/hpc/en/infrastructure) overview, there are two clusters with GPUs (at the time of writing): Joltic and Accelgor.
These machines are heavily used for production simulations,
so getting an interactive session on them may require (sometimes days of) queuing time.
In general, this is impractical, and we recommend using the GPU clusters for non-interactive work,
as will be explained later.
That said, if a GPU is available, you can also run your notebooks interactively with GPU acceleration.

This requires a few changes in the settings when running a Jupyter Notebook:

- **Cluster:** `joltik` or `accelgor`
- **Time (hours):** Fill in the time you will be working on the notebook.
 Your session will be killed when this time has passed.
- **Number of nodes:** always `1` in this course.
- **Number of cores:** `8` for `joltik`, `12` for `accelgor`.
- **Number of GPUs:** `1`
- **JupyterLab version:** `None (advanced)`
- **Custom code:**
   ```bash
   source ${VSC_DATA}/msbs/venvs/activate.sh
   export OPENMM_DEFAULT_PLATFORM=CUDA
   ```
- **Extra Jupyter Arguments:**
   ```bash
   --notebook-dir="${VSC_DATA}/msbs/openmm-tutorial-msbs"
   ```
- **Extra sbatch arguments:** leave empty
- **I would like to receive an email when the session starts:** this may be useful when all resources are in use, meaning your session cannot start instantly.

Once connected to Jupyter Lab, run the following test again in a new notebook:

```python
import openmm.testInstallation
openmm.testInstallation.main()
```

You should see the following output (or something similar):

```
OpenMM Version: 8.0
Git Revision: Unknown

There are 4 Platforms available:

1 Reference - Successfully computed forces
2 CPU - Successfully computed forces
3 CUDA - Successfully computed forces
4 OpenCL

1 warning generated.
1 warning generated.
1 warning generated.
1 warning generated.

- Successfully computed forces

Median difference in forces between platforms:

Reference vs. CPU: 6.30607e-06
Reference vs. CUDA: 6.72855e-06
CPU vs. CUDA: 7.37843e-07
Reference vs. OpenCL: 6.74399e-06
CPU vs. OpenCL: 7.66047e-07
CUDA vs. OpenCL: 2.14437e-07

All differences are within tolerance.
```
