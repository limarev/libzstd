#!/bin/bash

NDK_PATH=/opt/android_sdk/ndk-bundle
INSTALL_PATH=/share

PLATFORMS="armeabi-v7a arm64-v8a x86 x86_64"

BUILD_PATH=/tmp
mkdir -p $BUILD_PATH/install

for p in $PLATFORMS; do
    echo "Building $p:"
    mkdir -p $BUILD_PATH/install/$p
    mkdir -p $INSTALL_PATH/install/$p
    cmake \
        -DCMAKE_TOOLCHAIN_FILE=${NDK_PATH}/build/cmake/android.toolchain.cmake \
        -DANDROID_ABI=$p \
        -DCMAKE_ANDROID_ARCH_ABI=$p \
        -DANDROID_NDK=${NDK_PATH} \
        -DCMAKE_BUILD_TYPE=Release \
        -DCMAKE_SYSTEM_NAME=Android \
        -DCMAKE_SYSTEM_VERSION=21 \
        -DANDROID_PLATFORM=21 \
        -DCMAKE_INSTALL_PREFIX=${INSTALL_PATH}/install/$p \
        -S ${INSTALL_PATH}/android-zstd/build/cmake \
        -B $BUILD_PATH/install/$p || exit 1;

    cmake --build $BUILD_PATH/install/$p --target install
done
