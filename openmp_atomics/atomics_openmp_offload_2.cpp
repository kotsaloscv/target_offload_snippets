void sub() {
  int i{}, j{};
  __atomic_sub_fetch(&i, j, int());
}
int main() {
  #pragma omp target
  {
    sub();
  }
}
