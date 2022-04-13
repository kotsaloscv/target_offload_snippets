#!/bin/bash

# nvhpc
module purge
module load unstable gcc nvhpc cuda

CXX=nvc++
# Without O2, it crashes
CXXFLAGS="-mp=gpu -g -O2"
${CXX} ${CXXFLAGS} implicit_omp_declare_target.cpp
if [ -f a.out ] ; then ./a.out; echo $?; fi

# llvm
module purge
module load unstable llvm gcc

CXX=clang++
CXXFLAGS="-fopenmp -fopenmp-targets=nvptx64-nvidia-cuda"
${CXX} ${CXXFLAGS} implicit_omp_declare_target.cpp
if [ -f a.out ] ; then ./a.out; echo $?; fi

# intel
module purge
module load unstable intel-oneapi-compilers

CXX=icpx
CXXFLAGS="-qopenmp -fopenmp-targets=spir64 -g -O2"
${CXX} ${CXXFLAGS} implicit_omp_declare_target.cpp
if [ -f a.out ] ; then ./a.out; echo $?; fi

rm a.out
