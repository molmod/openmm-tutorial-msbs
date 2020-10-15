#!/usr/bin/env bash
#PBS -N _openmm
#PBS -l nodes=1:ppn=18
#PBS -l walltime=4:00:00

# Load the OpenMM module, still needs to be installed...
source ${VSC_SCRATCH_VO_USER}/miniconda3/bin/activate
conda activate openmm

# Change the filename of the notebook below
cd ${PBS_O_WORKDIR}
export OPENMM_NUM_THREADS=${SLURM_CPUS_ON_NODE}
time jupyter nbconvert --to notebook --execute --allow-errors --ExecutePreprocessor.timeout=-1 04_villin_headpiece.ipynb
