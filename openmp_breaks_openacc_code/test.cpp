#include "Eigen/Core"

int main() {
#if defined(_OPENMP) && !defined(_OPENACC)
#pragma omp target teams distribute parallel for simd
#else
#pragma acc parallel loop
#endif
  for(int i = 0; i < 1; ++i) {
    Eigen::Matrix<double, 1, 1> F;
    F.norm();
  }
  return 0;
}
