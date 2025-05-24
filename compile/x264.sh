#!/bin/bash

# 设置 NDK 路径，修改为你的 NDK 实际安装位置
export NDK=/Users/gang/Library/Android/sdk/ndk/22.1.7171670
export TOOLCHAIN=$NDK/toolchains/llvm/prebuilt/linux-x86_64

# 设置目标架构和 API 级别
export API=34
export TARGET=aarch64-linux-android
export PREFIX=$(pwd)/x264_android

# 设置编译器和工具链
export AR=$TOOLCHAIN/bin/llvm-ar
export AS=$TOOLCHAIN/bin/llvm-as
export CC=$TOOLCHAIN/bin/$TARGET$API-clang
export CXX=$TOOLCHAIN/bin/$TARGET$API-clang++
export LD=$TOOLCHAIN/bin/ld
export RANLIB=$TOOLCHAIN/bin/llvm-ranlib
export STRIP=$TOOLCHAIN/bin/llvm-strip
export NM=$TOOLCHAIN/bin/llvm-nm
export STRINGS=$TOOLCHAIN/bin/llvm-strings


# 配置 x264 编译选项
./configure \
    --prefix=$PREFIX \
    --disable-asm \
    --enable-static \
    --enable-pic \
	--host=aarch64-linux-android  \
    --cross-prefix=$TOOLCHAIN/bin/$TARGET$API- \
    --sysroot=$TOOLCHAIN/sysroot \
    --extra-cflags="-Os -fPIC" \

# 检查 configure 的输出日志
if [ $? -ne 0 ]; then
    echo "Configuration failed"
    exit 1
fi

# 编译和安装
make -j$(nproc)
if [ $? -ne 0 ]; then
    echo "Build failed"
    exit 1
fi

make install
if [ $? -ne 0 ]; then
    echo "Installation failed"
    exit 1
fi

echo "x264 has been successfully built and installed"