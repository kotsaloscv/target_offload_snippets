#include <openacc.h>
#include <iostream>
extern "C" void openacc() {
  constexpr auto data_size = 1024;
  auto* data = new double[data_size];
  auto* d_data = static_cast<double*>(acc_copyin(data, data_size*sizeof(double)));
  std::cout << "data = " << data << ", d_data = " << d_data << ", acc_deviceptr(data) = " << acc_deviceptr(data) << std::endl;
}
