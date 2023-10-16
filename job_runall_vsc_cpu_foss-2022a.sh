#!/bin/bash
#SBATCH --job-name cpu-vsc
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=10GB
#SBATCH --time=5:00:00

# Setup our OpenMM environment
module load OpenMM/8.0.0-foss-2022a MDTraj/1.9.7-foss-2022a matplotlib/3.5.2-foss-2022a jax/0.3.25-foss-2022a lxml/4.9.1-GCCcore-11.3.0 PyYAML/6.0-GCCcore-11.3.0
. ${VSC_DATA}/venvs/${VSC_ARCH_LOCAL}/3.10.4-GCCcore-11.3.0/bin/activate

# Set the number of threads.
export OPENMM_CPU_THREADS=${SLURM_CPUS_PER_TASK}
# Go to the directory where sbatch was called
cd ${SLURM_SUBMIT_DIR}

./runall.sh
