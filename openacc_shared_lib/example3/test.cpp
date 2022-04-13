#include <stdlib.h>
#include <stdio.h>

float* my_data;
#pragma acc declare create(my_data)

static double my_value = 1.0;
#pragma acc declare copyin(my_value)

double my_celsius;
#pragma acc declare create(my_celsius)

void init(double val) {
    my_data = (float*) malloc(sizeof(float)*3);
    my_data[0] = 1.1;
    #pragma acc enter data copyin(my_data[0:3])

    my_celsius = val;
    #pragma acc update device(my_celsius)
}

#pragma acc routine seq
double foo() {
    double y = 2.0;
    // 2 + 5 + 1 = 8
    return y + my_celsius + my_value;
}

void sample() {
  #pragma acc kernels present(my_celsius)
  {
     double val = foo();
     printf("\n VALUE :: %lf \n", val);
  }
}
