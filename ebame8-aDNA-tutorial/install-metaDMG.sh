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

cd "${APP_SRC}" || exit

git clone https://github.com/metaDMG-dev/metaDMG-cpp.git

cd metaDMG-cpp || exit

git checkout abd303e808c7d74166f305ac88ef538af9b1d44d

make clean && make -j 8

sudo mv metaDMG-cpp /usr/local/bin/

rm -rf "${APP_SRC}/metaDMG-cpp"
