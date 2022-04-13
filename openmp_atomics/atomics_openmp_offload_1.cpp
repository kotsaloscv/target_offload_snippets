#include <atomic>

int main() {
  #pragma omp target
  {
    std::atomic<int> x{};
    x -= 1;
  }
}
