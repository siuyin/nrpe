#!/bin/sh
# image_build.sh
PGM='nrpe'
MAIN_VER=20150704
#MAIN_VER=`date +%Y%m%d`
SUB_VER=
VER=${MAIN_VER}${SUB_VER}

docker build -t siuyin/${PGM}:${VER} .
