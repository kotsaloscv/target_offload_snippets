#include <stdio.h>

int main() {
  double *ptr = reinterpret_cast<double*>(0xdeadbeef);
  printf("ptr=%p\n", ptr);
  #pragma omp target parallel for simd is_device_ptr(ptr) if(true)
  for(int i = 0; i < 1; ++i) {
    printf("ptr=%p\n", ptr);
  }
  #pragma omp target parallel for simd if(true) is_device_ptr(ptr)
  for(int i = 0; i < 1; ++i) {
    printf("ptr=%p\n", ptr);
  }
  return 100;
}
