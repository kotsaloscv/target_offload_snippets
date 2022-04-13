#include <cstdio>
__host__ __device__ void foo() {
#ifdef __CUDA_ARCH__
  std::printf("hello from device\n");
#else
  std::printf("hello from host\n");
#endif
}
