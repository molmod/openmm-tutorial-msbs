# Introductory OpenMM tutorial

## 0. Conditions of use

The Python and Bash source code in this work are public domain and can be reused
without any restrictions.

The texts and images in the Jupyter notebooks, Markdown documents and other
files are licensed under the Creative Commons Attribution 4.0 International
License. To view a copy of this license, visit
http://creativecommons.org/licenses/by/4.0/ or send a letter to Creative
Commons, PO Box 1866, Mountain View, CA 94042, USA.

This tutorial shows how to use and install different software packages, which
have their own conditions of use.


## 1. Scope

This tutorial was written for the course Molecular Simulations of Biological
Systems (MSBS), a (very) introductory course for students of the MSc program
Biochemistry and Biotechnology at Ghent University. The main goal of the course
is to enable these students (who have a limited background in statistical
mechanics) to run sensible molecular dynamics simulations and to interpret the
results correctly. This tutorial assumes the students have a basic knowledge of
Python.

This tutorial is strongly inspired by several online resources (tutorials,
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
* MDTraj: http://mdtraj.org/1.9.3/
* CHARMM-GUI: http://www.charmm-gui.org/

Even though these resources contain all the background and details to learn
OpenMM and related tools, the amount of information is simply overwhelming.
The aim of this course is to provide a gentle introduction to many of the
topics in the above references.

## 2. Getting started

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
- Easy visualization (nglview).

Weaknesses:

- Installation requires some work.
- Overheating of your laptop, except for the smallest simulations.
- Laptop must remain on during calculations.

Instructions: [setup_on_your_laptop.md](setup_on_your_laptop.md)

### Google Colab

Strengths:

- Easy to get started.
- GPU acceleration.
- Interactive work.

Weaknesses:

- Network (and your laptop) must remain on during calculations.
- Output deleted after session.
- Transferring files is tedious.
- Google account required.
- No visualization of MD.

Instructions: [setup_on_google_colab.md](setup_on_google_colab.md)

### High-performance cluster

Strengths:

- Calculations in background, i.e. you can power off your laptop while they run.
- Computational power.

Weaknesses:

- Requires Linux knowledge.
- Queueing time.

Instructions: [setup_on_a_hpc.md](setup_on_a_hpc.md)


## 3. Overview of Jupyter Notebooks

The getting-started instructions showed you how to open a new notebook or to
start any notebook from this tutorial. The tutorial consists of the following
sections, to be followed in order:

1. `01/01_first_openmm_simulation.ipynb`
2. `02/02_alanine_dipeptide.ipynb`
3. `03/03_other_python_environments.ipynb`
4. `04/04_villin_headpiece.ipynb`
