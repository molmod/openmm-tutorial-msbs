# Setup on a HPC.

The instructions below also work on the VSC clusters, but our instructions in [setup_vsc.md](setup_vsc.md) are much better suited for users of the [Flemish Supercomputing Centre](https://www.vscentrum.be/).

This document can be used as a fallback when OpenMM is not installed on your cluster, and you have to install everything without any support from your admins.
If this is your first experience with the Linux operating system, it's recommended to get some help from a more experienced colleague when following the instructions below.

Note that we have tested the steps on a VSC cluster, but they should be easily adopted to any other HPC.
We assume the following:
- Access a virtual terminal on the HPC, using an SSH connection.
- Your cluster uses the Slurm scheduler. (If not, only some trivial changes are needed.)


## Installation

1. Use an SSH client to connect to a login node of the cluster.

1. Download the notebooks for the tutorials to the `$VSC_DATA` folder of your account so that you can access them at any time during the tutorial.
   This will also give you a copy of `job_install_vsc_foss-2021a.sh` on the cluster.
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
   sbatch job_install_hpc_mambaforge.sh
   ```

1. Check the output of the installation job.
   The last part should be something along the following lines:

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


## Submit a simple test job

Submit a simple job script on the queue, in which you perform the same test.

1. Run `nano job_openmm.sh` and add the following content, after which you save and close with `Ctrl-x`:

   ```bash
   #!/usr/bin/env bash
   #SBATCH --nodes=1
   #SBATCH --ntasks=1
   #SBATCH --cpus-per-task=1
   #SBATCH --time=0:15:00
   # Go to the directory where sbatch was executed.
   cd ${SLURM_SUBMIT_DIR}
   # Activate the OpenMM software.
   ROOT=...
   eval "$(${ROOT}/mambaforge/bin/conda shell.bash hook)"
   conda activate openmm
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

1. Switch to the Slaking cluster:
   `module swap cluster/slaking`.
   (This is very specific for the VSC clusters in Ghent, may be different elsewhere.)

1. Run the command `sbatch job_openmm.sh`.

1. Check the status of the job with `squeue`.

   After the job is submitted, you can safely log out (type `exit`), even switch off your laptop, and connect later to check the status of the job.
   When the job status is `C` (completed), or it is no longer present in the output of `squeue`, the job was executed and corresponding output files will be created.

1. The output of the test job should be similar to:

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


## Interactive notebooks

If your HPC runs an instance of [Open OnDemand](https://openondemand.org/), it is highly recommended to use it for interactive notebooks, instead of the following steps.
The VSC clusters can be used this way, and you may find some useful information in the [Setup for VSC](setup_vsc.md).
If you don't have access through Open OnDemand, the steps below give you a poor-man's approximation of what Open OnDemand can do.
These steps do assume that you can SSH into compute nodes on which your jobs are running.
That is allowed at VSC, but other HPC centers may be more restrictive.

Finally, note that all steps below are mildly hacky, but do work on VSC.
Significant adaptations may be needed on other HPCs.

1. Use a **first** virtual terminal and connect to the login node of your HPC with the `ssh` command.

   ```bash
   ssh vsc4YYXX@login.hpc.UGent.be -i ~/.ssh/id_rsa_vsc
   ```

   You may user a configuration file `~.ssh/config`, such that you can reduce the amount of command-line arguments.

1. Start an interactive Slurm job. (Note that the `module swap cluster/...` is very specific for VSC clusters in Gent. It gives you access to the debug cluster.)

   ```bash
   module swap cluster/slaking
   srun --pty -t 6:00:00 --nodes=1 --ntasks=1 --cpus-per-task=1 --mem=10GB bash
   ```

1. Start a Jupyter Notebook server in the interactive job:

   ```bash
   m
   conda activate openmm
   jupyter notebook --no-browser --port=8901
   ```

   Take note of the URL printed in the terminal: ```http://localhost:8901/?token=...```.
   You will need to enter this URL in your browser in one of the last steps.
   You may also use another port number, provided you used the same port consistently in all commands.

   (We could not get Jupyter Lab to work yet in this way.)

1. Open a **second** virtual terminal and log into the login node of the cluster with the following port-forwarding options:

   ```bash
   ssh vsc4YYXX@login.hpc.UGent.be -L 2222:nodeZZZZ.slaking.os:22 -i ~/.ssh/id_rsa_vsc
   ```

   This makes it possible to connect to the compute node directly from your laptop with SSH in the following step.

1. Open a **third** virtual terminal and log into the compute node with the following port-forwarding options:

   ```bash
   ssh vsc4XXYY@localhost -p 2222 -L 8901:localhost:8901 -i ~/.ssh/id_rsa_vsc
   ```

   where the last option refers to your private key.
   (It may be named differently on your machine.)
   The numbers in `8901:localhost:8901` have to match the port number of your Jupyter server.

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
