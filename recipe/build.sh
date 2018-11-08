#!/bin/bash

mkdir build
cd build

CUDA="OFF"
if [ "$cuda_impl" == "cuda" ]; then
    CUDA="ON"
    # build with c++11
    export CXXFLAGS=$(echo $CXXFLAGS | sed "s/-std=c++[0-9][0-9]//")
    export CXXFLAGS="$CXXFLAGS -std=c++11"
fi

export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:$PREFIX/lib/pkgconfig

cmake -G "Ninja"                                \
  -DCMAKE_INSTALL_PREFIX=$PREFIX                \
  -DCMAKE_PREFIX_PATH=$PREFIX                   \
  -DCMAKE_BUILD_TYPE=Release                    \
  -DWITH_CUDA=$CUDA                             \
  -DWITH_DAVIDSDK=OFF                           \
  -DWITH_DSSDK=OFF                              \
  -DWITH_ENSENSO=OFF                            \
  -DWITH_FZAPI=OFF                              \
  -DWITH_LIBUSB=OFF                             \
  -DWITH_OPENGL=ON                              \
  -DWITH_OPENNI=OFF                             \
  -DWITH_OPENNI2=OFF                            \
  -DWITH_PCAP=OFF                               \
  -DWITH_PNG=ON                                 \
  -DWITH_QHULL=OFF                              \
  -DWITH_QT=ON                                  \
  -DWITH_VTK=OFF                                \
  -DBUILD_global_tests=OFF                      \
  -DBUILD_examples=OFF                          \
  -DBUILD_tools=ON                              \
  -DBUILD_apps=OFF                              \
  -DCMAKE_LIBRARY_ARCHITECTURE=x86_64-linux-gnu \
  -DOpenGL_GL_PREFERENCE=GLVND                  \
  ..

ninja install
