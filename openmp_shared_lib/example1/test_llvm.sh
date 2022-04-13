#!/bin/bash

# llvm
module purge
module load unstable llvm gcc

export OMP_TARGET_OFFLOAD=MANDATORY
export LD_LIBRARY_PATH=$PWD:$LD_LIBRARY_PATH

CXX=clang++
FLAGS="-g -O3 -fpic -shared -fopenmp -fopenmp-targets=nvptx64-nvidia-cuda"

set -x

$CXX $FLAGS test_compute.cpp -o libtest_compute.so
g++ test.cpp -L. -ltest_compute -o test
./test

echo "Link with clang++ instead of g++"
$CXX test.cpp -L. -ltest_compute -o test
./test

rm test libtest_compute.so
