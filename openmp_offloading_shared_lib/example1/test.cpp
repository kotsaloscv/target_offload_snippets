#include <iostream>
#include <cstdlib>
#include "test_compute.h"

int main () {

int sze = 1024;
double * Arr = new double[sze];
for (int i=0; i < sze; ++i) {
Arr[i] = i;
}

addone(Arr,sze);

for (int i=0; i < 10; ++i) {
std::cout << i << ": " << Arr[i] << std::endl;
}

return 1;
}
