# eigen_offload_compatibility

To test:

1. `git clone --branch extend_CUDA_support https://github.com/BlueBrain/eigen.git`
2. - NVHPC:
   - `nvc++ -Ieigen -DEIGEN_DONT_VECTORIZE=1 -cuda -DUSE_OPENMP -acc -mp=gpu -o eigen_offload eigen.cpp`
   - `nvc++ -Ieigen -DEIGEN_DONT_VECTORIZE=1 -cuda -DUSE_OPENACC -acc -o eigen_offload eigen.cpp`
   - Intel One API:
   - `icpx -Ieigen -DEIGEN_DONT_VECTORIZE=1 -DUSE_OPENMP -qopenmp -fopenmp-targets=spir64 -o eigen_offload eigen.cpp`
3. Comment out the calls to `EIGEN_CPUID` macro in `eigen/Eigen/src/Core/util/Memory.h` to avoid compilation error: `invalid output constraint '=a' in asm`.
4. `./eigen_offload`
