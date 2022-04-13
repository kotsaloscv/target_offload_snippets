void a() {}

namespace n {
    #pragma omp declare target
    void b() { a(); }
    #pragma omp end declare target
}

int main () {
    return 100;
}
