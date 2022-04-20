#!/bin/bash

# nvhpc
module purge
module load unstable gcc nvhpc cuda

export LD_LIBRARY_PATH=$PWD:$LD_LIBRARY_PATH

CXX=nvc++

$CXX -acc -gpu=nordc -shared -o libfoo.so lib.cpp
g++ -ldl -o main main.cpp
./main

rm main *so
