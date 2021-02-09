#!/bin/bash

if [ ! $1 ]; then
  echo Expected system architecture as argument. For example:
  echo $0 linux-x86_64
  echo $0 linux-arm64
  echo $0 linux-armhf
  exit
fi

set -xe

rm -R build || true
mkdir build || true

pushd build

LIBV=1.5.4
ARCH=$1
OPENCV=4.4.0
BLAS=0.3.10

wget https://repo1.maven.org/maven2/org/bytedeco/javacpp/$LIBV/javacpp-$LIBV.jar
wget https://repo1.maven.org/maven2/org/bytedeco/javacpp/$LIBV/javacpp-$LIBV-$ARCH.jar
wget https://repo1.maven.org/maven2/org/bytedeco/javacpp-platform/$LIBV/javacpp-platform-$LIBV.jar
wget https://repo1.maven.org/maven2/org/bytedeco/javacv-platform/$LIBV/javacv-platform-$LIBV.jar
wget https://repo1.maven.org/maven2/org/bytedeco/openblas/$BLAS-$LIBV/openblas-$BLAS-$LIBV-$ARCH.jar
wget https://repo1.maven.org/maven2/org/bytedeco/openblas/$BLAS-$LIBV/openblas-$BLAS-$LIBV.jar
wget https://repo1.maven.org/maven2/org/bytedeco/openblas-platform/$BLAS-$LIBV/openblas-platform-$BLAS-$LIBV.jar
wget https://repo1.maven.org/maven2/org/bytedeco/opencv/$OPENCV-$LIBV/opencv-$OPENCV-$LIBV-$ARCH.jar
wget https://repo1.maven.org/maven2/org/bytedeco/opencv/$OPENCV-$LIBV/opencv-$OPENCV-$LIBV.jar
wget https://repo1.maven.org/maven2/org/bytedeco/opencv-platform/$OPENCV-$LIBV/opencv-platform-$OPENCV-$LIBV.jar


CV_JAR=opencv-$OPENCV-$LIBV-$ARCH.jar
BLAS_JAR=openblas-$BLAS-$LIBV-$ARCH.jar

# Mod opencv
    echo Modifying $CV_JAR

    rm -R mod || true
    mkdir mod || true
    pushd mod
    unzip ../$CV_JAR

    rm -R org/bytedeco/opencv/$ARCH/share/opencv4/haarcascades/
    rm -R org/bytedeco/opencv/$ARCH/python
    rm    org/bytedeco/opencv/$ARCH/libjniopencv_python3.so

    rm ../$CV_JAR

    zip -r ../$CV_JAR *

    popd # mod
    rm -R mod
# Done mod opencv

popd # build
