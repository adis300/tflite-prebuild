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
ARCH_NAME='darwin'
# bazel build --config opt --cpu=darwin_arm64 --host_cpu=darwin_arm64 //tensorflow/tools/lib_package:libtensorflow
cd $TF_SRC_DIR
python3 configure.py

bazel build --config=macos -c opt //tensorflow/lite/c:libtensorflowlite_c.dylib \
        --host_crosstool_top=@bazel_tools//tools/cpp:toolchain

mkdir -p $BUILD_DIR/macos/$ARCH_NAME

cp $TF_SRC_DIR/bazel-out/${ARCH_NAME}-opt/bin/tensorflow/lite/c/libtensorflowlite_c.dylib  $BUILD_DIR/macos/$ARCH_NAME/libtensorflowlite_c.dylib

cd $SCRIPT_DIR
mkdir -p $BUILD_DIR/include
cp $TF_SRC_DIR/tensorflow/lite/c/c_api_types.h $BUILD_DIR/include
cp $TF_SRC_DIR/tensorflow/lite/c/c_api.h $BUILD_DIR/include