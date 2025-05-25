# For more information about using CMake with Android Studio, read the
# documentation: https://d.android.com/studio/projects/add-native-code.html.
# For more examples on how to use CMake, see https://github.com/android/ndk-samples.

# Sets the minimum CMake version required for this project.
cmake_minimum_required(VERSION 3.22.1)

# Declares the project name. The project name can be accessed via ${ PROJECT_NAME},
# Since this is the top level CMakeLists.txt, the project name is also accessible
# with ${CMAKE_PROJECT_NAME} (both CMake variables are in-sync within the top level
# build script scope).
project("nativ")

# Creates and names a library, sets it as either STATIC
# or SHARED, and provides the relative paths to its source code.
# You can define multiple libraries, and CMake builds them for you.
# Gradle automatically packages shared libraries with your APK.
#
# In this top level CMakeLists.txt, ${CMAKE_PROJECT_NAME} is used to define
# the target library name; in the sub-module's CMakeLists.txt, ${PROJECT_NAME}
# is preferred for the same purpose.
#
# In order to load a library into your app from Java/Kotlin, you must call
# System.loadLibrary() and pass the name of the library defined here;
# for GameActivity/NativeActivity derived applications, the same library name must be
# used in the AndroidManifest.xml file.
add_library(${CMAKE_PROJECT_NAME} SHARED
        # List C/C++ source files with relative paths to this CMakeLists.txt.
        nativ.cpp)
#创建导入的库目标,FFmpeg7个SO库
add_library(avcodec SHARED IMPORTED)
add_library(avfilter SHARED IMPORTED)
add_library(avformat SHARED IMPORTED)
add_library(avutil SHARED IMPORTED)
add_library(swresample SHARED IMPORTED)
add_library(swscale SHARED IMPORTED)
add_library(avdevice SHARED IMPORTED)

#设置变量,CMAKE_SOURCE_DIR是CMakeList.txt的路径
set(LIB_DIR ${CMAKE_SOURCE_DIR}/../../../libs/${ANDROID_ABI})

#设置目标属性，例如avutil-55的IMPORTED_LOCATION属性值是${LIB_DIR}/libavutil-55.so
set_target_properties(avutil PROPERTIES IMPORTED_LOCATION ${LIB_DIR}/libavutil.so)
set_target_properties(swresample PROPERTIES IMPORTED_LOCATION ${LIB_DIR}/libswresample.so)
set_target_properties(avcodec PROPERTIES IMPORTED_LOCATION ${LIB_DIR}/libavcodec.so)
set_target_properties(avfilter PROPERTIES IMPORTED_LOCATION ${LIB_DIR}/libavfilter.so)
set_target_properties(swscale PROPERTIES IMPORTED_LOCATION ${LIB_DIR}/libswscale.so)
set_target_properties(avdevice PROPERTIES IMPORTED_LOCATION ${LIB_DIR}/libavdevice.so )
set_target_properties(avformat PROPERTIES IMPORTED_LOCATION ${LIB_DIR}/libavformat.so)

#在指定目录下搜索一个库, 保存在变量中
find_library(
        # 变量名
        log-lib
        #搜索log库
        log)

# Specifies libraries CMake should link to your target library. You
# can link libraries from various origins, such as libraries defined in this
# build script, prebuilt third-party libraries, or Android system libraries.
target_link_libraries(${CMAKE_PROJECT_NAME}
        # List libraries link to the target library
        android
        log
        avutil
        swresample
        avcodec
        avfilter
        swscale
        avdevice
        avformat)