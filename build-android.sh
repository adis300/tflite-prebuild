#!/bin/bash
set -e
cd ${0%/*}
SCRIPT_DIR=$(pwd)
TF_SRC_DIR=${SCRIPT_DIR}/tensorflow
BUILD_DIR=${SCRIPT_DIR}/tflite_build

# colorful echo functions
function echo_y() { echo -e "\033[1;33m$@\033[0m" ; }   # yellow
function echo_r() { echo -e "\033[0;31m$@\033[0m" ; }   # red

# build --action_env 
# ./configure
ANDROID_NDK_HOME="$HOME/Library/Android/sdk/ndk/21.4.7075529"
ANDROID_NDK_API_LEVEL="21"

ANDROID_BUILD_TOOLS_VERSION="33.0.0"
ANDROID_SDK_API_LEVEL="33"
ANDROID_SDK_HOME="$HOME/Library/Android/sdk"

rm -rf $BUILD_DIR

ARCHS="android_arm64 android_arm android_x86 android_x86_64"

for ARCH in ${ARCHS}
do
    cd $TF_SRC_DIR
    bazel build --config=$ARCH -c opt //tensorflow/lite/c:libtensorflowlite_c.so \
    --host_crosstool_top=@bazel_tools//tools/cpp:toolchain

    if [ "$ARCH" == "android_arm64" ]; then
        ARCH_NAME='arm64-v8a'
    elif [ "$ARCH" == "android_arm" ]; then
        ARCH_NAME='armeabi-v7a'
    elif [ "$ARCH" == "android_x86" ]; then
        ARCH_NAME='x86'
    elif [ "$ARCH" == "android_x86_64" ]; then
        ARCH_NAME='x86_64'
    fi

    mkdir -p $BUILD_DIR/android/$ARCH_NAME

    cp $TF_SRC_DIR/bazel-out/${ARCH_NAME}-opt/bin/tensorflow/lite/c/libtensorflowlite_c.so  $BUILD_DIR/android/$ARCH_NAME/libtensorflowlite_c.so

done

cd $SCRIPT_DIR
mkdir -p $BUILD_DIR/include
cp $TF_SRC_DIR/tensorflow/lite/c/c_api_types.h $BUILD_DIR/include
cp $TF_SRC_DIR/tensorflow/lite/c/c_api.h $BUILD_DIR/include

