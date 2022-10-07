#!/bin/bash
#SBATCH --job-name gpu-vsc
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gpus-per-task=1
#SBATCH --mem=10GB
#SBATCH --time=5:00:00

# Setup our OpenMM environment
module load OpenMM/7.7.0-foss-2021a-CUDA-11.3.1 MDTraj/1.9.7-foss-2021a matplotlib/3.4.2-foss-2021a jax/0.3.9-foss-2021a lxml/4.6.3-GCCcore-10.3.0 PyYAML/5.4.1-GCCcore-10.3.0
. ${VSC_DATA}/venvs/${VSC_ARCH_LOCAL}/3.9.5-GCCcore-10.3.0/bin/activate

# Set the number of threads.
export OPENMM_CPU_THREADS=${SLURM_CPUS_PER_TASK}
# Use CUDA for GPUs
export OPENMM_DEFAULT_PLATFORM=CUDA
# Go to the directory where sbatch was called
cd ${SLURM_SUBMIT_DIR}

./runall.sh
