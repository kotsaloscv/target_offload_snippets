#include <dlfcn.h>
#include <stdexcept>
using launch_t = int(*) ();
int main() {
  void* h = dlopen("./libshared_acc_rdc.so", RTLD_NOW);
  if(!h) { throw std::runtime_error{dlerror()}; }
  auto* launch = reinterpret_cast<launch_t>(dlsym(h, "launch"));
  if(!launch) { throw std::runtime_error{dlerror()}; }
  return launch();
}
