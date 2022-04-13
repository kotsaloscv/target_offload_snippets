#include "test_compute.h"

void addone(double * Arr, int sze) {
#pragma omp target teams distribute parallel for map(tofrom:Arr[0:sze])
#pragma acc parallel loop copy(Arr[0:sze])
for (int i=0; i<sze; ++i) {
Arr[i]+=1.0;
}
}
