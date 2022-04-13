#!/bin/bash

# nvhpc
module purge
module load unstable gcc nvhpc cuda

export LD_LIBRARY_PATH=$PWD:$LD_LIBRARY_PATH

CXX=nvc++

# Build 1
$CXX -acc test.cpp main.cpp
./a.out

# Build 2
$CXX -g -O3 -fpic -acc -shared test.cpp -o libtest.so
$CXX main.cpp -L. -ltest
./a.out

rm a.out *o
