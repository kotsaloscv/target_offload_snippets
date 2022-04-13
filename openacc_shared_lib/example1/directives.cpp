#pragma acc routine seq
void foo();

extern "C" int launch() {
  #pragma acc kernels
  {
    foo();
  }
  return 0;
}
