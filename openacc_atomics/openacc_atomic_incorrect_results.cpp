#include <algorithm>
#include <array>
#include <cassert>
#ifdef __NVCOMPILER
#include <openacc.h>
#endif
#include <string>
#include <vector>

int increment(int &counter, int always_zero) {
  int i;
  // This seems to be the problematic part:
  #pragma acc atomic capture
  i = counter++;
  // This condition is never satisfied. Replacing it with `always_zero` changes
  // which (wrong)  numbers are returned from this function (on our system).
  if ( i > 1000000 ) {
    assert(0); // replacing with printf makes issue go away
  }
  return i;
}
struct Indirector {
  // We could not reproduce the issue without this indirection.
  int *counter;
};
void kernel(bool compute_gpu, int size, bool always_true, int *record,
            Indirector *indirector, int always_zero) {
#pragma acc parallel loop copy(always_true, always_zero, record [0:2 * size])               \
    present(indirector [0:1]) if (compute_gpu)
  for (int i = 0; i < size; ++i) {
    if (always_true) {
      // record values from the first `increment` in the first half of the array
      record[i] = increment(*indirector->counter, always_zero);
    } else {
      record[i] = -2;
    }
    // record values from the second `increment` in the second half of the array
    record[size + i] = increment(*indirector->counter, always_zero);
  }
}

int main(int argc, char **argv) {
  std::size_t capacity{7};
  if ( argc > 1 ) {
    capacity = std::stoul(argv[1]);
  }
  bool global_pass{true};

  int counter;
  Indirector indirector;
  indirector.counter = &counter;
#ifdef __NVCOMPILER
  auto *d_indirector = static_cast<Indirector*>(acc_copyin(&indirector, sizeof(Indirector)));
  auto *d_nsb = acc_copyin(indirector.counter, sizeof(int));
  acc_memcpy_to_device(&d_indirector->counter, &d_nsb, sizeof(int*));
#endif
  for (int compute_gpu = 0; compute_gpu < 2; ++compute_gpu) {
    std::vector<int> record(2 * capacity, -1);
    counter = 0;
#pragma acc update device(counter) if (compute_gpu)
    kernel(compute_gpu, capacity, true, record.data(), &indirector, 0);
#pragma acc update self(counter) if (compute_gpu)
    assert(counter == int(record.size()));
    std::sort(record.begin(), record.end());
    printf("%s sorted values:", compute_gpu ? "GPU" : "CPU");
    bool pass = true;
    for (auto i = 0; i < int(record.size()); ++i) {
      auto val = record[i];
      if (val != i) {
        global_pass = pass = false;
      }
      printf(" %d", val);
    }
    printf(" %s\n", pass ? "[correct]" : "[incorrect]");
  }
  printf("%s\n", global_pass ? "PASS" : "FAIL");
  return !global_pass;
}
