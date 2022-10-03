## Alternative approach to run Jupyter Notebooks interactively

These instructions are intended for those who don't have access to the VSC clusters, and still want to use Jupyter notebooks interactively, with calculations running on a high-performance cluster (HPC).
It may also come in handy when visualization extensions do not work as expected on [login.hpc.ugent.be](https://login.hpc.ugent.be).

The steps below require some technical background of the `ssh` command.
At this stage, the instructions below are NOT useful for readers unfamiliar with `ssh`.

All commands below are tested on the Tier-2 VSC Cluster at Ghent University.
You may need to adapt them to work well on your HPC.

1. Make sure you have SSH access to the login node of the cluster.
   In addition, you also need SSH into the compute node where one of your jobs is running.
   Some HPC centers will not allow this, in which case the instructions below will not work.

1. Follow the installation instructions in [setup_on_a_hpc.md](setup_noninteractive_hpc.md).
   (The test job submission can be skipped.)

1. Use a **first** virtual terminal and connect to the login node of your HPC with the `ssh` command.

   ```bash
   ssh vsc4YYXX@login.hpc.UGent.be -i ~/.ssh/id_rsa_vsc
   ```

   You may user a configuration file `~.ssh/config`, such that you can reduce the amount of command-line arguments.

1. Start an interactive job.
   The following is suitable on the Tier-2 cluster at Ghent University.

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

1. Open a web browser and go the the URL ```http://localhost:8901/?token=...```.
   You should see a Jupyter session in your local browsers, with calculations running on the compute node.
   Enjoy!
