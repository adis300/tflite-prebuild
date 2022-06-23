#!/bin/bash
set -e
cd ${0%/*}
SCRIPT_DIR=$(pwd)
TF_SRC_DIR=${SCRIPT_DIR}/tensorflow
BUILD_DIR=${SCRIPT_DIR}/tflite_build

# colorful echo functions
function echo_y() { echo -e "\033[1;33m$@\033[0m" ; }   # yellow
function echo_r() { echo -e "\033[0;31m$@\033[0m" ; }   # red

cd $TF_SRC_DIR

python3 configure.py
bazel build //tensorflow/lite/c:tensorflowlite_c.dll -c opt

cd $SCRIPT_DIR

rm -rf $BUILD_DIR
mkdir -p $BUILD_DIR/apple/arm64
mkdir -p $BUILD_DIR/include

cp $SCRIPT_DIR/bazel-out/darwin_arm64-opt/bin/tensorflow/lite/c/tensorflowlite_c.dll  $BUILD_DIR/apple/arm64/tensorflowlite_c.dylib
cp $TF_SRC_DIR/tensorflow/lite/c/c_api_types.h $BUILD_DIR/include
cp $TF_SRC_DIR/tensorflow/lite/c/c_api.h $BUILD_DIR/include

