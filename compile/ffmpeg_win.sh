#!/bin/bash
set -e
#FFmpeg源码路径
SRC_DIR=D:/Projects/ffmpeg-7.1.1
DST_DIR=D:/Projects/ffmpeg_out
#NDK路径
NDK=D:/android-sdk/ndk/22.1.7171670/toolchains/llvm/prebuilt/windows-x86_64
API=30

cd $SRC_DIR

function build_onearch
{
    echo ">> configure $CPU start"
    ./configure \
      --enable-cross-compile \
      --target-os=android  \
      --prefix=$DST_DIR/$ANDROID_ABI  \
      --cross-prefix=$CROSS_PREFIX  \
      --cc=$CLANG_PREFIX --cxx=$CLANG_PREFIX++  \
      --arch=$ARCH \
      --sysroot=$NDK/sysroot \
      --enable-shared --disable-static \
      --enable-small --disable-programs --disable-doc \
      --enable-asm --enable-neon \
      --enable-jni --enable-mediacodec \
      --disable-vulkan #fatal error: 'vulkan_beta.h' file not found
     #--cpu=$CPU  \
    echo "<< configure $CPU finish"
    make clean
    make
    make install
}
 #编arm64-v8a动态库
ANDROID_ABI=arm64-v8a
ARCH=arm64
CPU=armv8-a
CROSS_PREFIX=$NDK/bin/aarch64-linux-android-
CLANG_PREFIX=$NDK/bin/aarch64-linux-android$API-clang
build_onearch
 #编armeabi-v7a动态库
ANDROID_ABI=armeabi-v7a
ARCH=arm
CPU=armv7-a
CROSS_PREFIX=$NDK/bin/arm-linux-androideabi-
CLANG_PREFIX=$NDK/bin/armv7a-linux-androideabi$API-clang
build_onearch

