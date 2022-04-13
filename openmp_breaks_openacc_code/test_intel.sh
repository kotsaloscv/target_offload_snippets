#!/bin/bash

module purge
module load unstable intel-oneapi-compilers

set -x

if ! [ -d eigen ] ; then
  git clone --branch extend_CUDA_support https://github.com/BlueBrain/eigen.git
fi

CXX=icpx
CXXFLAGS="-qopenmp -fopenmp-targets=spir64 -g -O2"
${CXX} ${CXXFLAGS} -Ieigen -DEIGEN_DONT_VECTORIZE=1 test.cpp -o omp_dev
./omp_dev

rm omp_dev
