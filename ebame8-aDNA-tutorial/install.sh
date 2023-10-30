#!/bin/bash -x

# This script is executed on the virtual machine during the Installation phase (need to be ran as root!).
# It is used to record a predefined VM-image of the appliance.
# Otherwise executed first during a cloud deployement in IFB-Biosphere

# Setting up the tutorial environment
APP_SRC="/home/ubuntu/opt/src"
BIN="/home/ubuntu/opt/bin"

mkdir -p "${APP_SRC}"
mkdir -p "${BIN}"

mamba env create -f https://raw.githubusercontent.com/genomewalker/ebame8/main/ebame8-aDNA-tutorial/mapping.yaml
mamba env create -f https://raw.githubusercontent.com/genomewalker/ebame8/main/ebame8-aDNA-tutorial/metaDMG.yaml

conda activate metaDMG

cd "${APP_SRC}" || exit

git clone https://github.com/metaDMG-dev/metaDMG-cpp.git

cd metaDMG-cpp || exit

git checkout abd303e808c7d74166f305ac88ef538af9b1d44d

make clean && make CPPFLAGS="-L${CONDA_PREFIX}/lib -I${CONDA_PREFIX}/include" HTSSRC=systemwide -j 8

mv metaDMG-cpp "${BIN}"

rm -rf "${APP_SRC}/metaDMG-cpp"

conda deactivate
