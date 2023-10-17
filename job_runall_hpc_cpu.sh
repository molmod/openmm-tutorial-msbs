#!/bin/bash
#SBATCH --job-name all-cpu-hpc
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=10GB
#SBATCH --time=5:00:00

# Setup our OpenMM environment
eval "$(${VSC_DATA}/mambaforge/bin/conda shell.bash hook)"
conda activate openmm
# Set the number of threads.
export OPENMM_CPU_THREADS=${SLURM_CPUS_PER_TASK}
# Go to the directory where sbatch was called
cd ${SLURM_SUBMIT_DIR}

./runall.sh
