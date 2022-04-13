#!/bin/bash

# nvhpc
module purge
module load unstable gcc nvhpc cuda

CXX=nvc++
CXXFLAGS="-acc -Wall -pedantic"
${CXX} ${CXXFLAGS} -o example openacc_atomic_incorrect_results.cpp

echo "*****>nvhpc"
if [ -f example ] ; then ./example; fi
rm example
echo "*****<"
