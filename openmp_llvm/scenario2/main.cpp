extern int test();

#include <cstdio>

#pragma omp declare target
extern int y;
#pragma omp end declare target

int main() {
  #pragma omp target teams distribute parallel for
  for(int i=0; i<5; i++) {
    printf("--> %d \n", y + i);
  }
  return test();
}
