#!/bin/bash
#SBATCH -J install_msbs_venv
#SBATCH -N 1
#SBATCH -t 1:00:00
#SBATCH --mem=5GB

# Note: this install script was tested on the Tier-2 cluster in Ghent.
# It is designed to work on other HPCs too, where OpenMM is not yet installed.
# Still, it may require some changes to work well on your cluster.
# They are all a little different.

# Everything will be installed under MSBS_ROOT.
MSBS_ROOT=${VSC_DATA}

if [[ -e "${MSBS_ROOT}/mambaforge" ]]; then
    echo "Installation root already exists: ${MSBS_ROOT}/mambaforge"
    echo "If you want to re-install, remove this directory first."
    exit 0
fi


# Download and install Mamba-forge
cd ${MSBS_ROOT}
wget https://github.com/conda-forge/miniforge/releases/latest/download/Mambaforge-Linux-x86_64.sh
bash Mambaforge-Linux-x86_64.sh -bfp ${MSBS_ROOT}/mambaforge

# Activate Mamba-forge.
eval "$(${ROOT}/mambaforge/bin/conda shell.bash hook)"

# Make sure your base environment is up-to-date.
mamba update --all -y
# Make a new environment for OpenMM, installing all the software, which takes some minutes.
mamba create -n openmm -y python cudatoolkit=10 git 'jupyterlab>=3.4.4' numpy pandas scipy matplotlib ipympl rdkit openbabel openmm mdtraj nglview pymbar pdbfixer parmed jupyter_contrib_nbextensions ipywidgets=7
# Activate the OpenMM environment
conda activate openmm
# Enable nglview and spell checker in Jupyter Notebooks.
jupyter nbextension enable spellchecker/main
jupyter nbextension enable nglview --py --sys-prefix

# Test the installation
python -m openmm.testInstallation
