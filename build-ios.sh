#!/bin/bash
set -e
cd ${0%/*}
SCRIPT_DIR=$(pwd)
TF_SRC_DIR=${SCRIPT_DIR}/tensorflow
BUILD_DIR=${SCRIPT_DIR}/tflite_build

# colorful echo functions
function echo_y() { echo -e "\033[1;33m$@\033[0m" ; }   # yellow
function echo_r() { echo -e "\033[0;31m$@\033[0m" ; }   # red

# python3 configure.py
rm -rf $BUILD_DIR
ARCHS="ios_arm64e ios_arm64 ios_sim_arm64 ios_x86_64" # ios_armv7 ios_i386

for ARCH in ${ARCHS}
do
    cd $TF_SRC_DIR
    bazel build --config=$ARCH -c opt //tensorflow/lite/c:libtensorflowlite_c.dylib \
        --host_crosstool_top=@bazel_tools//tools/cpp:toolchain

    if [ "$ARCH" == "ios_arm64" ]; then
        ARCH_NAME='ios_arm64'
    elif [ "$ARCH" == "ios_arm64e" ]; then
        ARCH_NAME='ios_arm64e'
    elif [ "$ARCH" == "ios_sim_arm64" ]; then
        ARCH_NAME='ios_sim_arm64'
    elif [ "$ARCH" == "ios_x86_64" ]; then
        ARCH_NAME='ios_x86_64'
    fi

    mkdir -p $BUILD_DIR/ios/$ARCH_NAME
    cp $TF_SRC_DIR/bazel-out/${ARCH_NAME}-opt/bin/tensorflow/lite/c/libtensorflowlite_c.dylib  $BUILD_DIR/ios/$ARCH_NAME/libtensorflowlite_c.dylib
done

#cd $TF_SRC_DIR
#bazel build --config=ios -c opt //tensorflow/lite/c:libtensorflowlite_c.dylib \
#    --config=ios --ios_multi_cpus="x86_64,arm64,arm64e"

cd $SCRIPT_DIR
mkdir -p $BUILD_DIR/include
cp $TF_SRC_DIR/tensorflow/lite/c/c_api_types.h $BUILD_DIR/include
cp $TF_SRC_DIR/tensorflow/lite/c/c_api.h $BUILD_DIR/include