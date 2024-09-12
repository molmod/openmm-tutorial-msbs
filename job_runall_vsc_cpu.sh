#!/bin/bash
#SBATCH --job-name all-cpu-vsc
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=10GB
#SBATCH --time=5:00:00

source ${VSC_DATA}/msbs/venvs/activate.sh
export OPENMM_CPU_THREADS=${SLURM_CPUS_PER_TASK}
./runall.sh
