# Setup for non-interactive OpenMM Jupyter Notebooks on (VSC) clusters.

Working with an HPC requires a basic knowledge of the Linux operating system.
If you have never used Linux before, this will be rich learning experience.
Still, it is worth the trouble, because in a computational research lab, any serious simulation is performed on an high-performance cluster (HPC).
Calculations on your laptop or on Google Colab are only useful for teaching, preparing simulations or initial prototyping.

**Note for Windows users.**
Be aware when connected to the HPC, you are working in a Linux environment even if you connect from your Windows PC.
So follow Linux instructions where needed throughout the tutorial any time you are connected to the HPC.

**Note for users NOT affiliated with a Flemish University.**
The instructions below will work for any HPC, except that the first three steps need to be replaced by another means of connecting to the cluster over SSH.
This can typically be found in the user documentation of your host institution's supercomputing center.

**Note for users affiliated with a Flemish University.**
- The exact procedure to request an account depends on your host institution.
Students at Ghent University can request a VSC account [here](https://www.ugent.be/hpc/en/access/policy/access#Students).
- If you are not familiar with virtual terminals, we refer to the [the UGent Linux and HPC tutorials](https://www.ugent.be/hpc/en/support/documentation.htm) for some general background.


## Installation

1. Navigate to [login.hpc.ugent.be](https://login.hpc.ugent.be) and follow the steps to log in.

1. In the blue top bar click `Clusters` > `login Shell Access`.
   A new tab should open with a black screen and a welcome message from the HPC cluster,
   containing some information on the current state of the cluster.

1. Determine a suitable directory to install Mamba-forge, which will be used to install and OpenMM.
   The directory should have sufficient quota (several Gigabytes) to contain the OpenMM installation.
   On the VSC clusters, this directory would be `$VSC_DATA`, but if you are working on another HPC, this might be different.
   In the instructions below, we will use `$VSC_DATA`, but this can be easily replaced.

1. Download and install Mamba-forge.

   ```bash
   cd $VSC_DATA
   wget https://github.com/conda-forge/miniforge/releases/latest/download/Mambaforge-Linux-x86_64.sh
   bash Mambaforge-Linux-x86_64.sh -bfp ${VSC_DATA}/mambaforge
   nano ~/.bashrc
   ```

   The last line will open a text editor in which the file `~/.bashrc` is opened.
   Add the following line to this file, save and close:

   ```bash
   alias m='eval "$(${VSC_DATA}/mambaforge/bin/conda shell.bash hook)"'
   ```

   You can save the file and close `nano` with the key combination `Ctrl-x`.

   Also execute the following command in your terminal:
   ```bash
   eval "$(${VSC_DATA}/mambaforge/bin/conda shell.bash hook)"
   ```

1. Create a new software environment, in which OpenMM will be installed.
   Python-3.9 is used below, to maintain consistency with the default Python version used by the Jupyter Notebooks on [login.hpc.ugent.be](https://login.hpc.ugent.be).

   ```bash
   # Make sure your base environment is up-to-date.
   mamba update --all
   # Make a new environment for OpenMM, installing all the software, which takes some minutes.
   # The mamba create command is too long to fit on your screen.
   # Make sure you copy it completely.
   mamba create -n py39openmm python=3.9 cudatoolkit git 'jupyterlab>=3.4.4' numpy pandas scipy matplotlib ipympl rdkit openbabel openmm mdtraj nglview pymbar pdbfixer parmed jupyter_contrib_nbextensions
   # Activate the OpenMM environment
   conda activate py39openmm
   # Enable nglview and spell checker in Jupyter Notebooks.
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


## Submit a simple test job

Submit a simple job script on the queue, in which you perform the same test.

- Run `nano job_openmm.sh` and add the following content, after which you save and close with `Ctrl-x`:

  ```bash
  #!/usr/bin/env bash
  #SBATCH --nodes=1
  #SBATCH --ntasks=1
  #SBATCH --cpus-per-task=1
  #SBATCH --time=0:15:00
  # Go to the directory where sbatch was executed.
  cd ${SLURM_SUBMIT_DIR}
  # Activate the OpenMM software.
  eval "$(${VSC_DATA}/mambaforge/bin/conda shell.bash hook)"
  conda activate py39openmm
  # Set the number of threads
  export OPENMM_CPU_THREADS=${SLURM_CPUS_ON_NODE}
  # Run the test.
  python test_openmm.py
  ```

- Run `nano test_openmm.py` and add the following content, after which you save and close with `Ctrl-x`:

  ```python
  import openmm.testInstallation
  openmm.testInstallation.main()
  ```

- Verify that both files are present by running `ls`.

- Switch to the Slaking cluster:
  `module swap cluster/slaking`.

- Run the command `sbatch job_openmm.sh`.

- Check the status of the job with `squeue`.

After the job is submitted, you can safely log out (type `exit`), even switch off your laptop, and connect later to check the status of the job.
When the job status is `C` (completed), or it is no longer present in the output of `squeue`, the job was executed and corresponding output files will be created.


## Usage

In section 3 of the tutorial, it will be explained how to run notebooks from this tutorial on an HPC.
This does not always make sense because you have to adapt your notebook to run correctly without any user interaction.
Most notebooks in this tutorial require you to experiment and make modifications interactively.
The method presented in section 3 is mainly useful when you want to run long calculations, without being connected to the cluster all the time.
