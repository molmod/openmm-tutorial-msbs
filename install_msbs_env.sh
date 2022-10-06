#!/bin/bash
#SBATCH -J install_msbs
#SBATCH -N 1
#SBATCH -t 1:00:00
#SBATCH --mem=10GB

# Note: this install script is designed to work well with
# the Tier-2 cluster in Ghent, on which OpenMM is already
# installed.

# You can select another OpenMM version.
# We also load matplotlib, to avoid re-installing it with pip.
# Just make sure you know the corresponding Python version.
OPENMM_VERSION='7.5.0-intel-2020b'
MATPLOTLIB_VERSION='3.3.3-intel-2020b'
PYTHON_VERSION='3.8.6-GCCcore-10.2.0'

# TODO: Other modules we should request, in addition to a newer version of OpenMM:
# - Pandas
# - Matplotlib
# - SciPy-bundle
# - MDTraj (potential for optimized compilation)

##########################################
# No changes required beyond this point. #
##########################################
ROOT=${VSC_DATA}/venvs/${VSC_ARCH_LOCAL}/${PYTHON_VERSION}
if [[ -e "${ROOT}" ]]; then
    echo "Installation root already exists: ${ROOT}"
    echo "If you want to re-install, remove this directory first."
    exit 0
fi

module load OpenMM/${OPENMM_VERSION}
module load matplotlib/${MATPLOTLIB_VERSION}
echo "Modules loaded before installing:"
module list

python -m venv ${ROOT}
. ${ROOT}/bin/activate
pip install -U pip
pip install -U notebook jupyterlab nglview ipywidgets==7.* ipympl pandas mdtraj pymbar parmed rdkit jupyter_contrib_nbextensions jupyterlab-spellchecker
pip install -U git+https://github.com/openmm/pdbfixer.git
pip install -U git+https://github.com/openforcefield/openff-toolkit.git@0.11.1
jupyter nbextension enable spellchecker/main
jupyter nbextension enable nglview --py --sys-prefix

echo "DONE!!"
echo
echo "# Custom code when launching a Jupyter Notebook with Open OnDemand"
echo "module purge"
echo "module load OpenMM/${OPENMM_VERSION}"
echo "module load matplotlib/${MATPLOTLIB_VERSION}"
echo '. ${VSC_DATA}/venvs/${VSC_ARCH_LOCAL}/'${PYTHON_VERSION}'/bin/activate'
