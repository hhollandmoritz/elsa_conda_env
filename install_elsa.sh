#!/bin/bash

# Install the conda environment:
conda env create -f elsa_install.yml --force

source $(conda info --base)/etc/profile.d/conda.sh
# Since the name changes with each version, make sure to pull the version
# name out of the yml file
ENV_NAME=$(awk '/name: elsa_env_v/{print $NF}' elsa_install.yml)
conda activate $ENV_NAME

# Download ELSA and unzip
echo "Downloading ELSA master branch"
wget https://bitbucket.org/charade/elsa/get/master.tar.gz
tar -zxvf master.tar.gz

cd charade-elsa*

# Install ELSA
echo "Installing ELSA"
python setup.py install

# Test installation
echo "Testing installation"
cd test
./test.sh
 
# Deactivate the conda environment
conda deactivate
