#!/bin/bash

# nvhpc
module purge
module load unstable gcc nvhpc cuda

nvc++ -acc -cuda -gpu=cc70,debug -g -fPIC -o directives.o -c directives.cpp
nvcc --generate-code=arch=compute_70,code=[compute_70,sm_70] -g -G -Xcompiler=-fPIC -o cuda.o -dc cuda.cu
nvc++ -acc -cuda -gpu=cc70,debug -g -shared -o libshared_acc_rdc.so directives.o cuda.o

g++ -ldl -o main_gcc dynamic.cpp

./main_gcc

rm *o main_gcc
