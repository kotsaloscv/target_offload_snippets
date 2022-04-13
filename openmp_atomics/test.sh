#!/bin/bash

# llvm
module purge
module load unstable llvm gcc

CXX=clang++
CXXFLAGS="-fopenmp -fopenmp-targets=nvptx64-nvidia-cuda -g -O2"
${CXX} ${CXXFLAGS} atomics_openmp_offload_1.cpp -o test1_
${CXX} ${CXXFLAGS} atomics_openmp_offload_2.cpp -o test2_

echo "*****>llvm"
if [ -f test1_ ] ; then ./test1_; echo $?; fi
if [ -f test2_ ] ; then ./test2_; echo $?; fi
rm test*_
echo "*****<"

# nvhpc
module purge
module load unstable gcc nvhpc cuda

CXX=nvc++
CXXFLAGS="-mp=gpu -g -O2"
${CXX} ${CXXFLAGS} atomics_openmp_offload_1.cpp -o test1_
${CXX} ${CXXFLAGS} atomics_openmp_offload_2.cpp -o test2_

echo "*****>nvhpc"
if [ -f test1_ ] ; then ./test1_; echo $?; fi
if [ -f test2_ ] ; then ./test2_; echo $?; fi
rm test*_
echo "*****<"

# intel
module purge
module load unstable intel-oneapi-compilers

CXX=icpx
CXXFLAGS="-qopenmp -fopenmp-targets=spir64 -g -O2"
${CXX} ${CXXFLAGS} atomics_openmp_offload_1.cpp -o test1_
${CXX} ${CXXFLAGS} atomics_openmp_offload_2.cpp -o test2_

echo "*****>intel"
if [ -f test1_ ] ; then ./test1_; echo $?; fi
if [ -f test2_ ] ; then ./test2_; echo $?; fi
rm test*_
echo "*****<"
