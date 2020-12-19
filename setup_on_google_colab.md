
# Installation of OpenMM on Google Colaboratory

:warning: WARNING. This document is kept here for future reference. However, the installation method described here easily breaks, depending on the version of OpenMM and the versions of various software libraries running on Google's servers.

Google Colab allows anyone (with a Google account) to run Python code inside a web browser, without having to install any other software on the local computer. Everything is executed in the cloud in Google's servers on which a lot of useful software is pre-installed. This takes away many of the technical barriers when getting started with Python. Google Colab mainly exists as a free service for the machine learning and data science communities, but you can also use it for any other purpose of interest, in our case running molecular dynamics simulations.

Before installing OpenMM in a Google Colab notebook, you first need to learn how Python and notebooks (on Google Colab) work. The following notebooks explains the basics:

- https://colab.research.google.com/notebooks/welcome.ipynb (Feel free to ignore anything specific to machine learning, such as Tensorflow and Seedbank.)
- https://colab.research.google.com/notebooks/basic_features_overview.ipynb (All sections are useful.)
- https://colab.research.google.com/notebooks/markdown_guide.ipynb (All sections are useful.)
- https://colab.research.google.com/notebooks/io.ipynb (Feel free to skip sections on PyDriver, REST API and GCS.)
- https://colab.research.google.com/notebooks/charts.ipynb (Only MatPlotLib will be used. The other plotting libraries are also nice, but not needed for this course.)

Now create a new Python 3 notebook, enable the GPU acceleration (Runtime -> Change runtime type, then select GPU under hardware accelerator.) In the first cell of the notebook, paste the following code.

```python
import sys
print(sys.version)
!wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
!bash Miniconda3-latest-Linux-x86_64.sh -bfp /usr/local
!conda config --set always_yes yes
!conda config --add channels omnia
!conda config --add channels conda-forge
!conda create -n openmm python=3.6 git rdkit openbabel openmm mdtraj nglview pymbar pdbfixer openmmforcefields openforcefields openmoltools parmed
sys.path.append('/usr/local/envs/openmm/lib/python3.6/site-packages')
# install the openforcefield package directly from github.
!pip install git+https://github.com/openforcefield/openforcefields@1.3.0
import simtk.testInstallation
simtk.testInstallation.main()
```

Executing this code cell will install OpenMM on the Linux machine running the notebook in Google's cloud (and it generates a lot of output). The last two lines test if the installation works as expected. Afterwards, you can run OpenMM simulations in the notebook. This OpenMM installation is removed as soon as you close your Notebook session.

In this course, Google Colab is only used as a fallback option, in case the alternatives are hampered by technical issues. It offers a great learning experience and GPU acceleration is convenient, but it does not support visualization of molecular dynamics simulations with NGLView, which is a major showstopper. Therefore, most of the hands-on session will be carried out in Jupyter notebooks running on your laptop.

To start any notebook from this tutorial on Google Colab, browse to https://colab.research.google.com/ and on the welcome screen, click on GITHUB in the orange bar. Enter the URL `https://github.com/molmod/openmm-tutorial-msbs` and press Enter. Select and open the desired notebook. You will then have to insert the code cell to install OpenMM above. When your simulation needs additional input files or generates output files of interest, additional code must be inserted to upload and download the inputs and outputs, respectively. A complete working example can be found here: [03_elsewhere/02_run_openmm_on_google_colab.ipynb](03_elsewhere/02_run_openmm_on_google_colab.ipynb).
