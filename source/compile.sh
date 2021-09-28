#!/bin/bash
# Clone Repository and compile NVTOP
cd ${DATA_DIR}
git clone https://github.com/Syllo/nvtop
git checkout ${LAT_V}
mkdir -p ${DATA_DIR}/nvtop/build
cd ${DATA_DIR}/nvtop/build
cmake .. -DCMAKE_INSTALL_PREFIX=/usr
make -j${CPU_COUNT}
DESTDIR=${DATA_DIR}/${LAT_V} make install
mkdir -p ${DATA_DIR}/v${LAT_V}

# Download icon and move it to destination
mkdir -p ${DATA_DIR}/${LAT_V}/usr/local/emhttp/plugins/nvtop/images
wget -q -O ${DATA_DIR}/${LAT_V}/usr/local/emhttp/plugins/nvtop/images/nvtop.png https://raw.githubusercontent.com/ich777/docker-templates/master/ich777/images/nvidia-driver.png 
cd ${DATA_DIR}/${LAT_V}

 # Create Slackware package 
makepkg -l n -c y ${DATA_DIR}/v$LAT_V/${APP_NAME}-"$(date +'%Y.%m.%d')".tgz
cd ${DATA_DIR}/v$LAT_V
md5sum ${APP_NAME}-"$(date +'%Y.%m.%d')".tgz | awk '{print $1}' > ${APP_NAME}-"$(date +'%Y.%m.%d')".tgz.md5