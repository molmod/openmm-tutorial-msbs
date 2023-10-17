# Setup on a HPC.

The instructions below also work on the VSC clusters, but our instructions in [setup_vsc.md](setup_vsc.md) are much better suited for users of the [Flemish Supercomputing Centre](https://www.vscentrum.be/).

This document can be used as a fallback when OpenMM is not installed on your cluster, and you have to install everything without any support from your admins.
If this is your first experience with the Linux operating system, it's recommended to get some help from a more experienced colleague when following the instructions below.

Note that we have tested the steps on a VSC cluster, but they should be easily adopted to any other HPC.
We assume the following:

- You have access to a virtual terminal on the HPC, using an SSH connection.
- Your cluster uses the Slurm scheduler.
  (If not, you need some trivial changes are needed, depending on the scheduler software.)
- If you are not working on a VSC cluster, replace `$VSC_DATA` in the instructions below and in the shell scripts by another location where you have a few GB of space.
- Your using the `bash` shell in your virtual terminal.

## Installation

1. Use an SSH client to connect to a login node of the cluster.

1. Download the notebooks for the tutorials to the `$VSC_DATA` folder of your account so that you can access them at any time during the tutorial.
   This will also give you a copy of `job_install_hpc.sh` on the cluster.
   Execute the following commands in the virtual terminal.

   ```bash
   cd $VSC_DATA
   wget https://github.com/molmod/openmm-tutorial-msbs/archive/main.zip
   unzip main.zip
   ```

   This creates a directory `openmm-tutorial-msbs-main` with a copy of the latest version of the tutorial.
   Enter this directory:

   ```bash
   cd openmm-tutorial-msbs-main
   ```

1. Submit the installation job as follows:

   ```bash
   sbatch job_install_hpc.sh
   ```

1. Check the output of the installation job.
   The last part should be something along the following lines:

   ```
   OpenMM Version: 8.0
   Git Revision: a7800059645f4471f4b91c21e742fe5aa4513cda

   There are 4 Platforms available:

   1 Reference - Successfully computed forces
   2 CPU - Successfully computed forces
   3 CUDA - Successfully computed forces
   1 warning generated.
   1 warning generated.
   1 warning generated.
   1 warning generated.
   4 OpenCL - Successfully computed forces

   Median difference in forces between platforms:

   Reference vs. CPU: 6.2894e-06
   Reference vs. CUDA: 6.74325e-06
   CPU vs. CUDA: 7.39638e-07
   Reference vs. OpenCL: 6.74399e-06
   CPU vs. OpenCL: 7.76254e-07
   CUDA vs. OpenCL: 2.11141e-07

   All differences are within tolerance.
   ```


## Submit a simple test job

Submit a simple job script on the queue, in which you perform the same test.

1. Run `nano job_openmm.sh` and add the following content.
   Change the variable `MSBS_ROOT` to match the location of your installation.
   When done, save and close with `Ctrl-x`:

   ```bash
   #!/usr/bin/env bash
   #SBATCH --nodes=1
   #SBATCH --ntasks=1
   #SBATCH --cpus-per-task=1
   #SBATCH --time=0:15:00
   # Go to the directory where sbatch was executed.
   cd ${SLURM_SUBMIT_DIR}
   # Activate the OpenMM software.
   MSBS_ROOT=${VSC_DATA}
   eval "$(${MSBS_ROOT}/mambaforge/bin/conda shell.bash hook)"
   source ${MSBS_ROOT}/mambaforge/etc/profile.d/mamba.sh
   mamba activate openmm
   # Set the number of threads
   export OPENMM_CPU_THREADS=${SLURM_CPUS_ON_NODE}
   # Run the test.
   python test_openmm.py
   ```

1. Run `nano test_openmm.py` and add the following content, after which you save and close with `Ctrl-x`:

   ```python
   import openmm.testInstallation
   openmm.testInstallation.main()
   ```

1. Verify that both files are present by running `ls`.

1. Run the command `sbatch job_openmm.sh`.

1. Check the status of the job with `squeue`.

   After the job is submitted, you can safely log out (type `exit`), even switch off your laptop, and connect later to check the status of the job.
   When the job status is `C` (completed), or it is no longer present in the output of `squeue`, the job was executed and corresponding output files will be created.

1. The output of the test job should be the same as that of the previous test.

1. Add the following to your `.bashrc` file, if you want to facilitate the activation of Mamba-forge, without having it always active:

   ```bash
   export MSBS_ROOT=${VSC_DATA}
   alias m='eval "$(${MSBS_ROOT}/mambaforge/bin/conda shell.bash hook)"; source ${MSBS_ROOT}/mambaforge/etc/profile.d/mamba.sh'
   ```


## Interactive notebooks (with Open OnDemand)

If your HPC runs an instance of [Open OnDemand](https://openondemand.org/), it is highly recommended to use it for interactive notebooks, instead of the hack explained in the next section.

1. Connect to the Open OnDemand portal of your cluster.
   The details of this works will different from cluster to cluster.
   Consult the documentation of your HPC Center for more details.

1. Click on `Interactive Apps` > `Jupyter Lab`.
   (Your HPC may not support Juptyer, in which case the remaining steps will not work.)

1. Select a cluster and the resources that you want to use.

   The details you need to fill in, will depend on how Open OnDemand is configured on your HPC.
   Again, consult its documentation for more details.

   You should at least take care of the following settings:

   - **Time (hours):** Fill in the time you will be working on the notebook.
     Your session will be killed when this time has passed.
   - **Number of nodes:** always `1` in this course.
   - **Number of cores:** `2` (This may be useful for combining visualization and computation loads. Feel free to increase for heavier MD runs. OpenMM can efficiently use more.)
   - **Custom code:** Fill in the following ...
     ```bash
     module purge
     eval "$(${MSBS_ROOT}/mambaforge/bin/conda shell.bash hook)"
     source ${MSBS_ROOT}/mambaforge/etc/profile.d/mamba.sh
     mamba activate openmm
     ```
   - **Extra Jupyter Arguments:** `--notebook-dir="${MSBS_ROOT}"`

   where `${MSBS_ROOT}` should be replaced by the location of your installation.

1. Scroll down and click the `Launch` button.

   Your job is placed in a queue and will only start when the requested resources become available.

   A new screen will appear showing the status of your request (queueing or about to start).
   Normally, you should get the following:

   ```
   Your session is currently starting... Please be patient as this process can take a few minutes.
   ```

1. After a few seconds, a button will appear saying `Connect to Jupyter`.
   Click this button and a Jupyter Notebook (or Lab) should open in a new tab.

1. On the right side of the page, there is a tab saying `New`. Click it.

1. Enter the following two lines in the first code cell and execute it by clicking on the play button in the toolbar (or typing Shift+Enter):

   ```python
   import openmm.testInstallation
   openmm.testInstallation.main()
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



## Interactive notebooks (without Open OnDemand)

If you don't have access through Open OnDemand, the steps below give you a poor-man's approximation of what Open OnDemand can do.
These steps do assume that you can SSH into compute nodes (on which your jobs are running).
That is allowed at VSC, but other HPC centers may be more restrictive.

Note that the steps below are a hack, but they do work on VSC.
Significant adaptations may be needed on other HPCs.

1. Use a **first** virtual terminal and connect to the login node of your HPC with the `ssh` command.

   ```bash
   ssh vsc4YYXX@login.hpc.UGent.be -i ~/.ssh/id_rsa_vsc
   ```

   You may use a configuration file `~.ssh/config` to reduce the amount of command-line arguments.

1. Start an interactive Slurm job.
   (It is recommended to run this job on a debug cluster or partition on which you have no queueing time.)

   ```bash
   srun --pty -t 6:00:00 --nodes=1 --ntasks=1 --cpus-per-task=2 --mem=10GB bash
   ```

1. Start a Jupyter Notebook server in the interactive job:

   ```bash
   m
   mamba activate openmm
   jupyter lab --no-browser --port=8901
   ```

   Take note of the URL printed in the terminal: ```http://localhost:8901/?token=...```.
   You will need to enter this URL in your browser in one of the last steps.
   You may also use another port number, provided you used the same port consistently in all commands.

1. Open a **second** virtual terminal and log into the login node of the cluster with the following port-forwarding options:

   ```bash
   ssh vsc4YYXX@login.hpc.UGent.be -L 2222:nodeZZZZ.donphan.os:22 -i ~/.ssh/id_rsa_vsc
   ```

   You need to modify the hostname of the compute node, here `nodeZZZZ.donphan.os`, to match the compute node of your interactive job.
   This makes it possible to connect to the compute node directly from your laptop with SSH in the following step.
   (We are assuming this is allowed on your HPC.)

1. Open a **third** virtual terminal and log into the compute node with the following port-forwarding options:

   ```bash
   ssh vsc4XXYY@localhost -p 2222 -L 8901:localhost:8901 -i ~/.ssh/id_rsa_vsc
   ```

   where the last option refers to your private key.
   (It may be named differently on your machine.)
   The numbers in `8901:localhost:8901` have to match the port number of your Jupyter server.

   Note that you are indeed connecting to your own machine, `localhost`, which is then forwarded by SSH to the compute node of your interactive job.

1. Open a web browser on your laptop and go the the URL ```http://localhost:8901/?token=...```.
   You should see a Jupyter session in your local browsers, with calculations running on the compute node.

1. Enter the following in a code cell and execute it:

   ```python
   import openmm.testInstallation
   openmm.testInstallation.main()
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


## Running a Notebook from the tutorial

Use the running Notebook session from the previous section.

1. Select and open a Notebook of your choice.
   For example, to get started, open the notebook `01_first_steps/01_water.ipynb`.

1. You should be able to run everything in the Notebook you just opened.

If you are not familiar with Jupyter Notebooks, the following resources can be helpful: [Jupyter Notebook Documentation](https://jupyter-notebook.readthedocs.io/en/latest/notebook.html).


## Non-interactive notebooks

You can also run notebooks non-interactively, as is explained in section 03 of the tutorial.
This is not always useful, because the tutorial contains many instructions to alter the notebooks and experiment with them interactively.
The method presented in section 3 is mainly useful when you want to run long calculations, without being connected to the cluster all the time.
