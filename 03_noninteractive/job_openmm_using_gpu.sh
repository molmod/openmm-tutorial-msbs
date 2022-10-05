#!/bin/bash
#SBATCH --job-name=_openmm
#SBATCH --nodes=1
#SBATCH --cpus-per-task=12
#SBATCH --gpus-per-task=1
#SBATCH --mem=5GB
#SBATCH --time=5:00:00

# Activate OpenMM.
eval "$(${VSC_DATA}/mambaforge/bin/conda shell.bash hook)"
conda activate py39openmm

# Go to the directory where qsub was executed.
cd ${SLURM_SUBMIT_DIR}

# Set the number of threads.
export OPENMM_CPU_THREADS=${SLURM_CPUS_PER_TASK}

# Run the notebook. (everything on a single line)
time jupyter nbconvert --to notebook --execute --allow-errors --ExecutePreprocessor.timeout=-1 01_run_openmm_on_a_hpc.ipynb
