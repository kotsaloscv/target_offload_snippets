# eigen_openacc_compatibility

To test:

1. `git clone --branch extend_CUDA_support https://github.com/BlueBrain/eigen.git`
2. `mkdir build && cd build`
3. `# cmake .. -DCMAKE_CXX_COMPILER=nvc++ -DCMAKE_CUDA_COMPILER=nvcc -DUSE_OPENACC=ON -DUSE_OPENMP=OFF && VERBOSE=1 make -j`
4. `./eigen_offload`
