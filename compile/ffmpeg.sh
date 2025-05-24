#!/bin/bash
API=24
NDK=/path/to/ndk
TOOLCHAIN=$NDK/toolchains/llvm/prebuilt/linux-x86_64

# 核心编译参数（新增安全加固和性能优化）
COMMON_FLAGS="
--target-os=android \
--enable-cross-compile \
--enable-shared \
--disable-static \
--disable-programs \
--disable-doc \
--enable-gpl \
--enable-small \
--disable-symver \
--enable-neon \
--enable-asm \
--extra-cflags='-fPIC -O3 -fstack-protector-strong -march=armv8-a' \
--extra-ldflags='-Wl,--build-id=sha1 -Wl,--exclude-libs,ALL' \
--sysroot=$TOOLCHAIN/sysroot"

# 编译arm64-v8a（新增Vulkan支持）
./configure $COMMON_FLAGS \
    --arch=aarch64 \
    --cpu=armv8-a \
    --enable-vulkan \
    --cross-prefix=$TOOLCHAIN/bin/aarch64-linux-android- \
    --cc=$TOOLCHAIN/bin/aarch64-linux-android$API-clang \
    --prefix=./android/arm64-v8a

make clean && make -j$(nproc) && make install