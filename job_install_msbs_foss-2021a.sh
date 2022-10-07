#!/bin/bash
#SBATCH -J install_msbs_venv
#SBATCH -N 1
#SBATCH -t 0:10:00
#SBATCH --mem=10GB

# Note: this install script is designed to work well with
# the Tier-2 cluster in Ghent, on which OpenMM is already
# installed.

# You can select another OpenMM version.
# We also load matplotlib, to avoid re-installing it with pip.
# Just make sure you know the corresponding Python version.
MODULE_REQUIREMENTS='OpenMM/7.7.0-foss-2021a MDTraj/1.9.7-foss-2021a matplotlib/3.4.2-foss-2021a jax/0.3.9-foss-2021a lxml/4.6.3-GCCcore-10.3.0 PyYAML/5.4.1-GCCcore-10.3.0'
PYTHON_VERSION='3.9.5-GCCcore-10.3.0'

##########################################
# No changes required beyond this point. #
##########################################
ROOT=${VSC_DATA}/venvs/${VSC_ARCH_LOCAL}/${PYTHON_VERSION}
if [[ -e "${ROOT}" ]]; then
    echo "Installation root already exists: ${ROOT}"
    echo "If you want to re-install, remove this directory first."
    exit 0
fi

module load ${MODULE_REQUIREMENTS}
echo "Modules loaded before installing:"
module list

python -m venv ${ROOT}
. ${ROOT}/bin/activate
pip install -U pip
pip install -U notebook jupyterlab nglview ipywidgets==7.* ipympl pymbar parmed rdkit jupyter_contrib_nbextensions jupyterlab-spellchecker
pip install -U git+https://github.com/openmm/pdbfixer.git
pip install -U git+https://github.com/openforcefield/openff-toolkit.git@0.11.1
jupyter nbextension enable spellchecker/main
jupyter nbextension enable nglview --py --sys-prefix

echo "DONE!!"
echo
echo "# Custom code when launching a Jupyter Notebook with Open OnDemand"
echo "module purge"
echo "module load ${MODULE_REQUIREMENTS}"
echo '. ${VSC_DATA}/venvs/${VSC_ARCH_LOCAL}/'${PYTHON_VERSION}'/bin/activate'
