#!/bin/bash
#SBATCH -J install-msbs-mamba
#SBATCH -N 1
#SBATCH -t 1:00:00
#SBATCH --mem=5GB

# Note: this install script was tested on the Tier-2 cluster in Ghent.
# It is designed to work on other HPCs too, where OpenMM is not yet installed.
# Still, it may require some changes to work well on your cluster.
# They are all a little different.

# Everything will be installed under MSBS_ROOT.
MSBS_ROOT=${VSC_DATA}/msbs

if [[ -e "${MSBS_ROOT}/mambaforge" ]]; then
    echo "Installation root already exists: ${MSBS_ROOT}/mambaforge"
    echo "If you want to re-install, remove this directory first."
    exit 0
fi

# Download and install Mamba-forge
(
  cd ${MSBS_ROOT}
  wget https://github.com/conda-forge/miniforge/releases/latest/download/Mambaforge-Linux-x86_64.sh
  bash Mambaforge-Linux-x86_64.sh -bfp ${MSBS_ROOT}/mambaforge
)

# Activate Mamba-forge.
eval "$(${MSBS_ROOT}/mambaforge/bin/conda shell.bash hook)"
source ${MSBS_ROOT}/mambaforge/etc/profile.d/mamba.sh

# Make sure your base environment is up-to-date.
mamba update --all -y

# Make a new environment for OpenMM, installing all the software, which takes some minutes.
mamba env create -f environment.yaml

# Write or update the jupyterlab default configuration
CENV=${MSBS_ROOT}/mambaforge/envs/openmm
mkdir -p ${CENV}/share/jupyter/lab/settings/
cp overrides.json ${CENV}/share/jupyter/lab/settings/
mkdir -p ${CENV}/etc/ipython/
cp ipython_kernel_config.py ${CENV}/etc/ipython/

# Update the default matplotlib settings
mkdir -p ${CENV}/etc/matplotlib/
cp matplotlibrc ${CENV}/etc/matplotlib/

# Activate the OpenMM environment
mamba activate openmm

# Test the installation
python -m openmm.testInstallation
