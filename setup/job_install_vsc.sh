#!/bin/bash
#SBATCH -J install-msbs-vsc
#SBATCH -N 1
#SBATCH -t 0:10:00
#SBATCH --mem=10GB

# Note: this install script is designed to work well with
# the Tier-2 cluster in Ghent, on which OpenMM is already
# installed.

MODULE_REQUIREMENTS="
OpenMM/8.0.0-foss-2023a
MDTraj/1.9.9-gfbf-2023a
lxml/4.9.2-GCCcore-12.3.0
PyYAML/6.0-GCCcore-12.3.0
RDKit/2024.03.3-foss-2023a
"
MODULE_REQUIREMENTS=$(tr '\n' ' ' <<< ${MODULE_REQUIREMENTS})
PYTHON_VERSION='3.11.3-GCCcore-12.3.0'
PYTHON_RELEASE=$(awk -F. '{print $1"."$2}' <<< ${PYTHON_VERSION})
VSC_ARCH="${VSC_ARCH_LOCAL}${VSC_ARCH_SUFFIX}"
PIP_TOOLS="pip==24.2 build==1.2.1 pip-tools==7.4.1 pyproject-hooks==1.1.0"
ROOT=${VSC_DATA}/msbs
VENV=${ROOT}/venvs/${VSC_ARCH}/${PYTHON_VERSION}

if [[ -e "${VENV}" ]]; then
    echo "Installation root already exists: ${VENV}"
    echo "This script will upgrade the existing env."
    echo "If you want to re-install from scratch, remove this directory first."
fi

module load ${MODULE_REQUIREMENTS}
echo "Modules loaded before installing:"
module list

python -m venv ${VENV} --system-site-packages
source ${VENV}/bin/activate
pip install ${PIP_TOOLS}

pip-sync requirements_python-${PYTHON_RELEASE}.txt

# Write or update the jupyterlab default configuration
mkdir -p ${VENV}/share/jupyter/lab/settings/
cp overrides.json ${VENV}/share/jupyter/lab/settings/
mkdir -p ${VENV}/etc/ipython/
cp ipython_kernel_config.py ${VENV}/etc/ipython/

# Update the default matplotlib settings
mkdir -p ${VENV}/etc/matplotlib/
cp matplotlibrc ${VENV}/etc/matplotlib/

# Write or update the central activate script
cat > ${ROOT}/venvs/activate.sh << EOL
# Load software environment
# By uncommenting the purge, the notebooks start faster,
# it becomes mandatory to select "None (advanced)" for JupyterLab version in OnDemand
module purge
module load ${MODULE_REQUIREMENTS}
source ${ROOT}/venvs/\${VSC_ARCH_LOCAL}\${VSC_ARCH_SUFFIX}/${PYTHON_VERSION}/bin/activate

# Make sure that Python programs (like Jupyter) are aware
# of the Python packages installed in the venv.
export PYTHONPATH="\${VIRTUAL_ENV}/lib/python3.11/site-packages:\${PYTHONPATH}"

# Set matplotlibrc location
export MATPLOTLIBRC=\${VIRTUAL_ENV}/etc/matplotlib/matplotlibrc
EOL

echo 'DONE!!'
echo
echo '# Settins for Jupyter Lab Interactive App at login.hpc.ugent.be'
echo '# JupyterLab version'
echo 'None (advanced)'
echo '# Custom code:'
echo 'source ${VSC_DATA}/msbs/venvs/activate.sh'
echo '# Extra Jupyter Arguments:'
echo '--notebook-dir="${VSC_DATA}/msbs/openmm-tutorial-msbs"'
