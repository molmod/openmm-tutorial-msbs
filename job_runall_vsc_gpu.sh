#!/bin/bash
#SBATCH --job-name all-gpu-vsc
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gpus-per-task=1
#SBATCH --mem=10GB
#SBATCH --time=5:00:00

# Submit this job on accelgor or joltik.
source ${VSC_DATA}/msbs/venvs/activate.sh
export OPENMM_CPU_THREADS=${SLURM_CPUS_PER_TASK}
export OPENMM_DEFAULT_PLATFORM=CUDA
./runall.sh
