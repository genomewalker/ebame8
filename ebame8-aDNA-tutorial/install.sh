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

mamba env create -f https://raw.githubusercontent.com/genomewalker/ebame8/main/ebame8-aDNA-tutorial/mapping.yaml
mamba env create -f https://raw.githubusercontent.com/genomewalker/ebame8/main/ebame8-aDNA-tutorial/metaDMG.yaml
