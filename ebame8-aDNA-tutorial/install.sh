#!/bin/bash -x
set -e
set -o pipefail
# This script is executed on the virtual machine during the Installation phase (need to be ran as root!).
# It is used to record a predefined VM-image of the appliance.
# Otherwise executed first during a cloud deployement in IFB-Biosphere

# Setting up the tutorial environment

APP_SRC="/home/${USER}/ebame8-adna/opt/src"
BIN="/home/${USER}/ebame8-adna/opt/bin"

mkdir -p "${APP_SRC}"
mkdir -p "${BIN}"

echo ". /home/${USER}/.bashrc" >>"/home/${USER}/.bash_profile"

wget -O "/home/${USER}/bashrc" https://raw.githubusercontent.com/genomewalker/dotfiles/master/shell/bash/.bashrc

cat "/home/${USER}/bashrc" >>"/home/${USER}/.bashrc"
rm "/home/${USER}/bashrc"
." /home/${USER}/.bash_profile"

wget -O /tmp/Mambaforge.sh "https://github.com/conda-forge/miniforge/releases/latest/download/Mambaforge-$(uname)-$(uname -m).sh"
bash /tmp/Mambaforge.sh -b -p "/home/${USER}/ebame8-adna/opt/conda"

source "/home/${USER}/ebame8-adna/opt/conda/etc/profile.d/conda.sh"

conda init bash

#/dockerstartup/kasm_default_profile.sh /dockerstartup/vnc_startup.sh /dockerstartup/kasm_startup.sh &
# echo "source $${STARTUPDIR}/generate_container_user" >>/home/${USER}/.bashrc

. "/home/${USER}/.bashrc"

conda config --set auto_activate_base false
conda config --add channels defaults
conda config --add channels bioconda
conda config --add channels conda-forge
conda config --set channel_priority strict

mamba env create -f https://raw.githubusercontent.com/genomewalker/ebame8/main/ebame8-aDNA-tutorial/mapping.yaml
mamba env create -f https://raw.githubusercontent.com/genomewalker/ebame8/main/ebame8-aDNA-tutorial/metaDMG.yaml

conda init bash
conda activate metaDMG

cd "${APP_SRC}" || exit

git clone https://github.com/metaDMG-dev/metaDMG-cpp.git

cd metaDMG-cpp || exit

git checkout abd303e808c7d74166f305ac88ef538af9b1d44d

make clean && make CPPFLAGS="-L${CONDA_PREFIX}/lib -I${CONDA_PREFIX}/include" HTSSRC=systemwide -j 8

mv metaDMG-cpp "${BIN}"

rm -rf "${APP_SRC}/metaDMG-cpp"

conda deactivate
