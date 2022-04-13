#!/bin/bash

# nvhpc
module purge
module load unstable gcc nvhpc cuda

CXX=nvc++
CXXFLAGS="-mp=gpu"
${CXX} ${CXXFLAGS} openmp_target_offload_clause_ordering.cpp
if [ -f a.out ] ; then ./a.out; echo $?; fi

# llvm
module purge
module load unstable llvm gcc

CXX=clang++
CXXFLAGS="-fopenmp -fopenmp-targets=nvptx64-nvidia-cuda"
${CXX} ${CXXFLAGS} openmp_target_offload_clause_ordering.cpp
if [ -f a.out ] ; then ./a.out; echo $?; fi

# intel
module purge
module load unstable intel-oneapi-compilers

CXX=icpx
CXXFLAGS="-qopenmp -fopenmp-targets=spir64"
${CXX} ${CXXFLAGS} openmp_target_offload_clause_ordering.cpp
if [ -f a.out ] ; then ./a.out; echo $?; fi

rm a.out
