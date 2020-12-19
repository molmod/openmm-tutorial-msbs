
# Install OpenMM in a HPC environment.

Working with an HPC requires a basic knowledge of the Linux operating system. If you have never used Linux before, this will be rich learning experience. Still, it is worth the trouble, because in a computational  research lab, any serious simulation is performed on a HPC. Calculations on your laptop or on Google Colab are only useful for teaching, preparing simulations or initial prototyping.

1. Windows users that have not used Secure Shell (SSH) before, should first install a Secure Shell client. This is only needed on Windows, since MacOS and Linux come with a built-in `ssh` program. Th recommend SSH client for Windows is MobaXTerm (free version), which can be found here: https://mobaxterm.mobatek.net/

2. You are now ready to request a HPC account, for which the exact procedure depends on your host institution. Students at Ghent University can [create a VSC account](request_vsc_account_ugent.md).

3. Configure the SSH connection to the HPC.

    - On Linux and MacOS, add the following to the file `~/.ssh/config`:

        ```
        Host hpc
            Hostname login.hpc.UGent.be
            user vsc4XXXX
            IdentityFile /home/YYYY/.ssh/id_rsa
        ```
        where `XXXX` should be replaced by your VSC ID and `YYYY` is the username on your laptop.

    - On Windows, ???

4. Connect to the HPC

    - On Linux and MacOS, run the following in a terminal:

        ```bash
        ssh hpc
        ```

    - On Windows, ???

    Now that your account is working, go through the Linux and HPC tutorials here: https://www.ugent.be/hpc/en/support/documentation.htm. (These are somewhat geared to VSC users at one of the Flemish universities, but they are general enough for audience.)

5. After connecting to the HPC, determine a suitable location to install Minoconda. This is a slimmed-down version of Anaconda, which is suitable for non-local installations. The data directory should have sufficient quota (several Gigabytes) to contain the OpenMM installation. On the VSC clusters, this directory would be `$VSC_DATA`, but if you are working on another HPC, this might be different. In the instructions below, we will use `$VSC_DATA`, but this can be easily replaced.

6. The installation of OpenMM takes several steps. First download and install Miniconda.

    ```bash
    cd $VSC_DATA
    wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
    bash Miniconda3-latest-Linux-x86_64.sh -bfp ${VSC_DATA}/miniconda
    gedit ~/.bashrc
    ```

    The last line will open a text editor in which the file `~/.bashrc` is opened. Add the following line to this file, save and close:

    ```bash
    alias c="source ${VSC_DATA}/miniconda/bin/activate"
    ```

    Log out of the HPC and log in again with SSH. Now we can install OpenMM into the conda environment:

    ```bash
    c
    conda config --add channels conda-forge
    conda create -n openmm git jupyter numpy pandas scipy matplotlib ipympl rdkit openbabel openmm mdtraj nglview pymbar pdbfixer parmed
    conda activate openmm
    conda install -c omnia openforcefield openmoltools openmmforcefields
    # Install the latest version of the openforcefield package directly from github.
    pip install git+https://github.com/openforcefield/openforcefields@1.3.0
    ```

7. Run the following command to test the OpenMM software:

    ```bash
    python -m simtk.testInstallation
    ```

8. The final test is to submit a simple job script on the queue, in which you perform the same test.

    - Run `gedit job_openmm.sh` and add the following content, after which you save and close gedit:

        ```bash
        #!/usr/bin/env bash
        #PBS -N _job_openmm
        #PBS -l walltime=0:05:00
        #PBS -l nodes=1:ppn=1
        # Go to the directory where qsub was executed.
        cd ${PBS_O_WORKDIR}
        # Activate the OpenMM software.
        source ${VSC_DATA}/miniconda/bin/activate
        conda activate openmm
        # Run the test.
        python test_openmm.py
        ```

    - Run `gedit test_openmm.py` and add the following content, after which you save and close gedit:

        ```python
        import simtk.testInstallation
        simtk.testInstallation.main()
        ```

    - Verify that both files are present by running `ls`.

    - Run the command `qsub job_openmm.sh`.

    - Check the status of the job with `qstat`.

    After the job is submitted, you can safely log out (type `exit`), even switch off your laptop, and connect later to check the status of the job. When the job status is `C` (completed) or it is no longer present in the output of `qstat`, the job was executed and corresponding outfiles will be created.

Later in the tutorial, it will be explained how to run notebooks from this tutorial on a HPC. This does not make sense in all cases because you have to adapt your notebook to run correctly without any user interaction. Most notebooks in this tutorial require you to make modifications.
