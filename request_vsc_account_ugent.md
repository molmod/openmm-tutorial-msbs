# Create a VSC account (UGent students)

## Windows users

These instructions assume you have installed the [MobaXTerm](https://mobaxterm.mobatek.net/) SSH client. The official UGent HPC documentation of our university uses PuTTY, a historical and even more Spartan SSH client for Windows. The instructions below show you how to use MobaXTerm instead.

Request a VSC account as explained here, until you see `PuTTY` being mentioned: https://www.ugent.be/hpc/en/access/policy/access#Students. At some point in the instructions, you need to generate an SSH key, which must be uploaded when requesting the account. This can be done with MobaXTerm (instead of PuTTY) as follows:

1. Enable the persistent home-directory option in the MobaXTerm configuration. Go to `Settings`->`Configuration`->`General` and set the `Persistent home directory` to the folder of your choice. The SSH keys generated in the next step will be stored in that directory (or in a subdirectory thereof).

2. Run a local terminal window. On the terminal command-line, enter the following:

    ```bash
    ssh-keygen -t rsa -b 4096
    ```

    Follow the instructions shown on screen (defaults are OK, empty passphrase is fine). This will generate a private-public key pair in the directory `.ssh`, of which the public file, `id_rsa.pub`, needs to be uploaded when requesting the account.

3. BSc or MSc Students will only be granted an account if a lecturer (or thesis supervisor) sends an additional motivation to the HPC team, so also inform your lecturer or supervisor when requesting the account.

## MacOS and Linux users

Follow the instructions given here: https://www.ugent.be/hpc/en/access/policy/access#Students.
