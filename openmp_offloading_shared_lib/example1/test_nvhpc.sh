#!/bin/bash

# nvhpc
module purge
module load unstable gcc nvhpc cuda

export OMP_TARGET_OFFLOAD=MANDATORY
export LD_LIBRARY_PATH=$PWD:$LD_LIBRARY_PATH

CXX=nvc++
FLAGS="-g -O3 -fpic -mp=gpu -shared"

set -x

$CXX $FLAGS test_compute.cpp -o libtest_compute.so
g++ test.cpp -L. -ltest_compute -o test
./test

echo "Link with nvc++ instead of g++"
$CXX test.cpp -L. -ltest_compute -o test -mp=gpu
./test

# Ok if using OpenACC
FLAGS="-g -O3 -fpic -acc=gpu -shared"
export NV_ACC_TIME=1

$CXX $FLAGS test_compute.cpp -o libtest_compute.so
g++ test.cpp -L. -ltest_compute -o test
./test

rm test libtest_compute.so
