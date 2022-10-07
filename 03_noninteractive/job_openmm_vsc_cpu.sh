#!/bin/bash
#SBATCH --job-name=vsc-cpu
#SBATCH --nodes=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=5GB
#SBATCH --time=5:00:00

# Setup our OpenMM environment
module load OpenMM/7.7.0-foss-2021a MDTraj/1.9.7-foss-2021a matplotlib/3.4.2-foss-2021a jax/0.3.9-foss-2021a lxml/4.6.3-GCCcore-10.3.0 PyYAML/5.4.1-GCCcore-10.3.0
. ${VSC_DATA}/venvs/${VSC_ARCH_LOCAL}/3.9.5-GCCcore-10.3.0/bin/activate

# Set the number of threads.
export OPENMM_CPU_THREADS=${SLURM_CPUS_PER_TASK}
# Go to the directory where sbatch was called
cd ${SLURM_SUBMIT_DIR}

# Run the notebook. (everything on a single line)
time jupyter nbconvert --to notebook --execute --allow-errors --ExecutePreprocessor.timeout=-1 01_noninteractive_notebook_on_hpc.ipynb
