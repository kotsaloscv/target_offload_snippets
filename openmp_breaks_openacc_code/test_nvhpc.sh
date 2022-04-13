#!/bin/bash

module purge
module load unstable gcc cuda nvhpc

# -cuda -> without this, there are issues (at every compilation stage)
CFLAGS="-Ieigen -DEIGEN_DONT_VECTORIZE=1 -cuda"
LDFLAGS="-cuda"
FLAGS_acc="-acc"
RESULT_acc=0
FLAGS_acc_omp_host="-acc -mp"
RESULT_acc_omp_host=0
FLAGS_acc_omp_dev="-acc -mp=gpu"
RESULT_acc_omp_dev=1
FLAGS_omp_dev="-mp=gpu"
RESULT_omp_dev=1

set -x

if ! [ -d eigen ] ; then
  git clone --branch extend_CUDA_support https://github.com/BlueBrain/eigen.git
fi

for config in acc acc_omp_host acc_omp_dev omp_dev
do
  flags_name="FLAGS_${config}"
  result_name="RESULT_${config}"
  expected_result=${!result_name}
  nvc++ ${CFLAGS} ${!flags_name} -c test.cpp -o test.${config}.o
  nvc++ ${LDFLAGS} ${!flags_name} -o ${config} test.${config}.o
  ./${config}
  if [[ $? != ${expected_result} ]]; then
    echo "Unexpected result: $?"
  fi
done

rm acc* omp* test.acc* test.omp*
