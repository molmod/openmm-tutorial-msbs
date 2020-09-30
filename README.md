# Introductory OpenMM tutorial

## Conditions of use

The Python and Bash source code in this work are public domain and can be reused
without any restrictions.

The texts and images in the Jupyter notebooks, Markdown documents and other
files are licensed under the Creative Commons Attribution 4.0 International
License. To view a copy of this license, visit
http://creativecommons.org/licenses/by/4.0/ or send a letter to Creative
Commons, PO Box 1866, Mountain View, CA 94042, USA.

This tutorial shows how to use and install different software packages, which
have their own conditions of use.


## Scope

This tutorial was written for the course Molecular Simulations of Biological
Systems (MSBS), a (very) introductory course for students of the MSc program
Biochemistry and Biotechnology at Ghent University. The main goal of the course
is to enable these students (who have a limited background in statistical
mechanics) to run sensible molecular dynamics simulations and to interpret the
results correctly. This tutorial assumes the students have a basic knowledge of
Python.

All material strongly inspired by several online resources (tutorials,
documentation and examples) of the OpenMM, Python, NumPy, Matplotlib and
other projects. The main pointers are:

* OpenMM website: http://openmm.org/
* OpenMM Users Guide: http://docs.openmm.org/latest/userguide/index.html
* OpenMM script builder: http://builder.openmm.org
* Python website: https://www.python.org/
* Python tutorial: https://docs.python.org/3/tutorial/index.html
* NumPy website: https://numpy.org/
* NumPy Users Guid: https://docs.scipy.org/doc/numpy/user/index.html
* MatPlotLib website: https://matplotlib.org/
* nglview: http://nglviewer.org/nglview/latest/
* MDTraj: http://mdtraj.org/
* CHARMM-GUI: http://www.charmm-gui.org/

Even though these resources contain all the background and details to learn
OpenMM and related tools, the amount of information is simply overwhelming.
The aim of this course is to provide a gentle introduction to many of the
topics in the above references.

## Installation of OpenMM

Practically all simulations in this tutorial are carried with OpenMM, which is
described in extenso
[here](http://docs.openmm.org/latest/userguide/library.html). In short,
OpenMM is a modern open-source biomolecular simulation toolkit: it supports many
popular biomolecular force fields (AMBER, CHARMM, AMOEBA), it supports
GPU-accelerated calculations and it can carry out many types of advanced
molecular dynamics simulations.

To access and customize all these features, and to write reproducible simulation
protocols, OpenMM simulations are implemented by writing Python scripts. Hence,
to install OpenMM, you need (to create) a Python environment and install OpenMM
as a Python package. (The C++ interfaces is not covered in this tutorial.)

For this tutorial, three environments can be used to perform simulations, each
having there strengths and weaknesses. It is recommended to follow this tutorial
by running Jupyter notebooks on your own laptop, as explained below. Google
Colab can be used as a fallback in case the installation of OpenMM on your
laptop failed. In section 3 of the tutorial, it is discussed how to transfer a
notebook from your laptop to Google Colab or to an HPC environment (and back).

### Your laptop

Strengths:

- Calculations require no network.
- Output files are stored locally.
- Easy visualization in the notebook with nglview.
- You can work interactively.

Weaknesses:

- The installation requires some work.
- Your laptop could overheat when running longer simulations.
- Yout laptop must remain powered on during calculations.

Installation instructions: [setup_on_your_laptop.md](setup_on_your_laptop.md)

### Google Colab

Strengths:

- Requires no software installation on your laptop, other than a web browser.
- GPU acceleration can speed up calculations.
- You can work interactively.

Weaknesses:

- Your laptop must remain powered on during the calculations and your network connection cannot drop.
  Especially when connected through Eduroam, this can be challenging.
- Output files are deleted after closing your notebook session.
- Transferring files from and to your laptop is tedious and slow.
- A Google account required.
- Trajectories cannot be visualized inside a notebook because nglview is not supported.

Installation Instructions: [setup_on_google_colab.md](setup_on_google_colab.md)

### High-performance cluster

Strengths:

- Calculations run in the background on a remote machine. You can power off your laptop while they run.
- You have access to more computational power.

Weaknesses:

- Some Linux knowledge is required.
- Your calculations do not start instantly. Instead, you submit "jobs" which are executed when a compute node becomes available.

Installation instructions: [setup_on_a_hpc.md](setup_on_a_hpc.md)


## Starting the tutorial

This section assumes you have just installed OpenMM, following the instructions of the previous section.

### Laptop

To start any notebook from the tutorial, download [the ZIP file with the most recent notebooks](https://github.com/molmod/openmm-tutorial-msbs/archive/master.zip) and unzip this archive.

- On Windows open a Conda prompt and change the directory to where you unzipped the archive. If needed, first change to the correct drive, e.g. by typing the command `D:`, then use e.g. `cd` folowed by the name of the directory where the ZIP file was unpacked.

- On MacOS or Linux, open any terminal emulator and change the directory to where you unzipped the archive. There is no need to change drives and the usage of `cd` is similar to Windows.

Then enter the following commands:

```bash
conda activate openmm
jupyter notebook
```

A browser window should pop up in which you can select and open a notebook. If
you are not familiar with notebooks, the following resources can be helpful:
[Jupyter Notebook Introduction](https://jupyter-notebook.readthedocs.io/en/stable/notebook.html#starting-the-notebook-server).

### Other environments (Google Colab and HPC)

Instructions for these environments are part of the tutorial below, see
directory `03_elsewhere`.


## Overview of Tutorial Sections

The getting-started instructions showed you how to open a new notebook or to
start any notebook from this tutorial. The tutorial consists of the following
sections, to be followed more-or-less in order:

**1. First steps:**

- [01_first_steps/01_water.ipynb](01_first_steps/01_water.ipynb)
- [01_first_steps/02_lennard_jones.ipynb](01_first_steps/02_lennard_jones.ipynb)

**2. Different ways of simulating analine dipeptide:**

- [02_alanine_dipeptide/01_force_fields.ipynb](02_alanine_dipeptide/01_force_fields.ipynb)

**3. Running OpenMM notebooks in other places:**

- [03_elsewhere/01_run_openmm_on_a_hpc.ipynb](03_elsewhere/01_run_openmm_on_a_hpc.ipynb)
- [03_elsewhere/02_run_openmm_on_google_colab.ipynb](03_elsewhere/02_run_openmm_on_google_colab.ipynb)

**4. A short protein MD simulation:**

- [04_protein/01_villin_headpiece.ipynb](04_protein/01_villin_headpiece.ipynb)

**5. Analysis of MD trajectories:**

- [05_analysis/01_internal_coordinates_averages.ipynb](05_analysis/01_internal_coordinates_averages.ipynb)
- [05_analysis/02_physicochemical_properties.ipynb](05_analysis/02_physicochemical_properties.ipynb)
- [05_analysis/03_alignment_principal_component_analysis.ipynb](05_analysis/03_alignment_principal_component_analysis.ipynb)

**6. Visalization**

- [06_visualization/visualization.md](06_visualization/visualization.md)

**7. Ligands**

- [07_ligands/01_ibuprofen.ipynb](07_ligands/01_ibuprofen.ipynb)


## Trouble shooting

A list of common problems is compiled here: [FAQ.md](FAQ.md)
