# Introductory OpenMM tutorial

## Conditions of use

[![License: CC BY-NC 4.0](https://i.creativecommons.org/l/by-nc/4.0/88x31.png)](https://creativecommons.org/licenses/by-nc/4.0/)
All files in this repository are licensed under a [Creative Commons Attribution-NonCommercial 4.0 International License](http://creativecommons.org/licenses/by-nc/4.0/). Contributions are welcome, see [CONTRIBUTING.md](https://github.ugent.be/Py4Sci/.github/blob/main/CONTRIBUTING.md) for more details.

This tutorial shows how to use and install different software packages, which have their own conditions of use.


## Scope

This tutorial was written for the course [Molecular Simulations of Biological Systems (MSBS)](https://studiegids.ugent.be/2020/EN/studiefiches/C002727.pdf), an introductory elective course for students of the M.Sc. program [Biochemistry and Biotechnology](https://studiegids.ugent.be/2020/EN/FACULTY/C/MABA/CMBCBT/CMBCBT.html) at [Ghent University](https://www.ugent.be/en).
The main goal of the course is to enable these students (who have a limited background in statistical mechanics) to run sensible molecular dynamics simulations and to interpret the results correctly.
This tutorial assumes the students have a basic knowledge of [Python](https://www.python.org/).

All materials are strongly inspired by several online resources (tutorials, documentation and examples) of the OpenMM, Python, NumPy, Matplotlib and other projects.
The main references are:

* OpenMM website: http://openmm.org/
* OpenMM Users Guide: http://docs.openmm.org/latest/userguide/index.html
* Python website: https://www.python.org/
* Python tutorial: https://docs.python.org/3/tutorial/index.html
* NumPy website: https://numpy.org/
* NumPy Users Guide: https://docs.scipy.org/doc/numpy/user/index.html
* MatPlotLib website: https://matplotlib.org/
* nglview: http://nglviewer.org/nglview/latest/
* MDTraj: http://mdtraj.org/

Even though these resources contain all the background and details to learn OpenMM and related tools, the amount of information is simply overwhelming.
The aim of this course is to provide a gentle introduction to many of the topics in the above references.

## Installation of OpenMM

Practically all simulations in this tutorial are carried out with OpenMM, which is described extensively [here](http://docs.openmm.org/latest/userguide/library.html).
In short, OpenMM is a modern open-source biomolecular simulation toolkit: it supports many popular biomolecular force fields (AMBER, CHARMM, AMOEBA), it supports
GPU-accelerated calculations, and it can carry out many types of advanced molecular dynamics simulations.

To access and customize all these features, and to write reproducible simulation protocols, OpenMM simulations are implemented by writing Python scripts.
Hence, to install OpenMM, you need (to create) a Python environment and install OpenMM as a Python package.
(The C++ interface is not covered in this tutorial.)

For this tutorial, three environments can be used to perform simulations, each having their strengths and weaknesses:

- If you have access to the Flemish Supercomputer Center (VSC) (i.e. you are affiliated to a Flemish research institution), it is recommended to run the simulations via an interactive session on the cluster as explained below.
- For all other users, it is recommended to follow this tutorial by running Jupyter notebooks on your own laptop.
- For simulations that take longer, section 3 of the tutorial explains how to transfer a notebook from your laptop to an HPC environment (and back) for non-interactive job submissions.


### Interactive Jupyter Notebooks on the *Vlaams Supercomputer Centrum* High-performance cluster

**Strengths:**

- Output files are stored on the cluster.
- Easy visualization in the notebook with nglview.
- You can work interactively.
- You have access to significant computational power.

**Weaknesses:**

- The installation requires some work.
- There is a predefined duration of your interactive session.
- The session ends without warning, which may lose you some progress.
- You must remain connected during the sessions.
- This feature is relatively new and may still have some hidden flaws.

Installation instructions: [setup_interactive_vsc.md](setup_interactive_vsc.md).

(For not affiliated with a Flemish University: [setup_interactive_hpc.md](setup_interactive_hpc.md).)

### Your laptop

**Strengths:**

- Calculations require no network.
- Output files are stored locally.
- Easy visualization in the notebook with nglview.
- You can work interactively.

**Weaknesses:**

- The installation requires some work.
- Your laptop could overheat when running longer simulations.
- Your laptop must remain powered on during calculations.
- Currently not working on Windows.

Instructions: [setup_laptop.md](setup_laptop.md).


### Non-interactive job submission on a High-performance cluster (HPC)

**Strengths:**

- Calculations run in the background on a remote machine. You can power off your laptop while they run.
- You have access to more computational power.

**Weaknesses:**

- Some Linux knowledge is required.
- Your calculations do not start instantly.
  Instead, you submit "jobs" which are executed when a compute-node becomes available.
- Non-interactive: the entire notebook is executed and you only get to see the results when it has all completed.

Instructions: [setup_noninteractive_hpc.md](setup_noninteractive_hpc.md).


## Overview of Tutorial Sections

The getting-started instructions showed you how to open a new notebook or to start any notebook from this tutorial.
The tutorial consists of the following sections, to be followed more-or-less in order:

**1. First steps:**

- [01_first_steps/01_water.ipynb](01_first_steps/01_water.ipynb)
- [01_first_steps/02_lennard_jones.ipynb](01_first_steps/02_lennard_jones.ipynb)

**2. Different ways of simulating analine dipeptide:**

- [02_alanine_dipeptide/01_force_fields.ipynb](02_alanine_dipeptide/01_force_fields.ipynb)

**3. Run demanding OpenMM notebooks as a non-interactive job:**

- [03_noninteractive/01_run_openmm_on_a_hpc.ipynb](03_noninteractive/01_run_openmm_on_a_hpc.ipynb)

**4. A short protein MD simulation:**

- [04_protein/01_villin_headpiece.ipynb](04_protein/01_villin_headpiece.ipynb)

**5. Analysis of MD trajectories:**

- [05_analysis/01_internal_coordinates_averages.ipynb](05_analysis/01_internal_coordinates_averages.ipynb)
- [05_analysis/02_physicochemical_properties.ipynb](05_analysis/02_physicochemical_properties.ipynb)
- [05_analysis/03_alignment_principal_component_analysis.ipynb](05_analysis/03_alignment_principal_component_analysis.ipynb)

**6. Visualization**

- [06_visualization/visualization.md](06_visualization/visualization.md)

**7. Ligands** (This part is still under development and does not work at the moment.)

- [07_ligands/01_ibuprofen_gas_phase.ipynb](07_ligands/01_ibuprofen_gas_phase.ipynb)
- [07_ligands/02_ibuprofen_solvent.ipynb](07_ligands/02_ibuprofen_solvent.ipynb)


## Troubleshooting

A list of common problems is compiled here: [FAQ.md](FAQ.md)
