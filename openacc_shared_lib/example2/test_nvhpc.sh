#!/bin/bash

# nvhpc
module purge
module load unstable gcc nvhpc cuda

# if we remove -cuda it works...
nvc++ -acc -gpu=cc70,lineinfo -cuda -gpu=nordc -fPIC -o minimal_directives.o -c minimal_directives.cpp
nvc++ -acc -gpu=cc70,lineinfo -cuda -gpu=nordc -fPIC -shared -o libshared.so minimal_directives.o
nvc++ -o main minimal_main.cpp
./main
echo $?

g++ -ldl -o main_gcc minimal_main.cpp
./main_gcc
echo $?

rm main main_gcc *o
