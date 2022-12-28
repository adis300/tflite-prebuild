#!/bin/bash
set -e
cd ${0%/*}
SCRIPT_DIR=$(pwd)
TF_SRC_DIR=${SCRIPT_DIR}/tensorflow
BUILD_DIR=${SCRIPT_DIR}/tflite_build

# colorful echo functions
function echo_y() { echo -e "\033[1;33m$@\033[0m" ; }   # yellow
function echo_r() { echo -e "\033[0;31m$@\033[0m" ; }   # red

rm -rf $BUILD_DIR
ARCH="macos"
ARCH_NAME='armhf'
# bazel build --config opt --cpu=darwin_arm64 --host_cpu=darwin_arm64 //tensorflow/tools/lib_package:libtensorflow
cd $TF_SRC_DIR
python3 configure.py

bazel build --config=elinux_$ARCH_NAME -c opt //tensorflow/lite/c:libtensorflowlite_c.so

mkdir -p $BUILD_DIR/pi/$ARCH_NAME

cp $TF_SRC_DIR/bazel-out/$ARCH_NAME-opt/bin/tensorflow/lite/c/libtensorflowlite_c.so  $BUILD_DIR/pi/$ARCH_NAME/libtensorflowlite_c.so

cd $SCRIPT_DIR
mkdir -p $BUILD_DIR/include
cp $TF_SRC_DIR/tensorflow/lite/c/c_api_types.h $BUILD_DIR/include
cp $TF_SRC_DIR/tensorflow/lite/c/c_api.h $BUILD_DIR/include