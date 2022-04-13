#pragma omp declare target
int y;
#pragma omp end declare target

int test() {
  y = 24;
  #pragma omp target update to(y)
  y = 42;

  int x;
  #pragma omp target map(from:x)
  {
    x = y;
  }
  return x;
}
