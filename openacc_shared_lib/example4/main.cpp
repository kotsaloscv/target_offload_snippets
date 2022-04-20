#include <dlfcn.h>
#include <stdexcept>
int main() {
  void* h = dlopen("./libfoo.so", RTLD_NOW);
  if(!h) { throw std::runtime_error{(std::string{"dlopen: "} + dlerror()).c_str()}; }
  auto* openacc = reinterpret_cast<void(*)()>(dlsym(h, "openacc"));
  if(!openacc) { throw std::runtime_error{(std::string{"dlsym: "} + dlerror()).c_str()}; }
  openacc();
  return 0;
}
