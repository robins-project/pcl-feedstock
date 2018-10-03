#!/bin/bash

mkdir build
cd build

CUDA="OFF"
if [ "$cuda_impl" == "cuda" ]; then
    CUDA="ON"
    # build with c++11
    export CXXFLAGS=$(echo $CXXFLAGS | sed "s/-std=c++17/-std=c++11/")
fi

cmake -G "Ninja" \
  -DCMAKE_INSTALL_PREFIX=$PREFIX \
  -DCMAKE_BUILD_TYPE=Release \
  -DWITH_CUDA=$CUDA \
  -DWITH_DAVIDSDK=OFF \
  -DWITH_DSSDK=OFF \
  -DWITH_ENSENSO=OFF \
  -DWITH_FZAPI=OFF \
  -DWITH_LIBUSB=OFF \
  -DWITH_OPENGL=ON \
  -DWITH_OPENNI=OFF \
  -DWITH_OPENNI2=OFF \
  -DWITH_PCAP=OFF \
  -DWITH_PNG=ON \
  -DWITH_QHULL=OFF \
  -DWITH_QT=ON \
  -DWITH_VTK=OFF \
  -DBUILD_global_tests=OFF \
  -DBUILD_examples=OFF \
  -DBUILD_tools=ON \
  -DBUILD_apps=OFF \
  -DOPENGL_egl_LIBRARY=/usr/lib/x86_64-linux-gnu/libEGL.so \
  -DOPENGL_glu_LIBRARY=/usr/lib/x86_64-linux-gnu/libGLU.so \
  -DOPENGL_glx_LIBRARY=/usr/lib/x86_64-linux-gnu/libGLX.so \
  -DOPENGL_opengl_LIBRARY=/usr/lib/x86_64-linux-gnu/libOpenGL.so \
  -DOPENGL_gl_LIBRARY=/usr/lib/x86_64-linux-gnu/libGL.so \
  -DOpenGL_GL_PREFERENCE=GLVND \
  ..

ninja install
