extern "C" int launch() {
  int x{3};

  #if defined(_OPENMP) && !defined(_OPENACC)
  #pragma omp target map(tofrom:x)
  #else
  #pragma acc kernels copy(x)
  #endif
  {
    x = 42;
  }
  return x != 42;
}
