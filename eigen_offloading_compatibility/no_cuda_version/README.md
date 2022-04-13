# eigen_openacc_compatibility

To test:

1. `git clone --branch extend_CUDA_support https://github.com/BlueBrain/eigen.git`
2. - `nvc++ -Ieigen -DEIGEN_DONT_VECTORIZE=1 -cuda -DUSE_OPENMP -acc -mp=gpu -o eigen_offload eigen.cpp`
   - `nvc++ -Ieigen -DEIGEN_DONT_VECTORIZE=1 -cuda -DUSE_OPENACC -acc -o eigen_offload eigen.cpp`
3. `./eigen_offload`
