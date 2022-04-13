#include "api.h"
#include <random>

int main() 
{
    std::random_device rd; // seeding
    std::mt19937 mt(rd());
    std::uniform_real_distribution<double> nums(-10, 10);

    MatType *A = (MatType*)malloc(sizeof(MatType));
    VecType *b = (VecType*)malloc(sizeof(VecType));

    do
    {
        // initialization
        for(int r = 0; r < DIM; r++) {
            for(int c = 0; c < DIM; c++) {
                (*A)(r,c) = nums(mt);
            }
            (*b)(r) = nums(mt);
        }
    } while (!A->fullPivLu().isInvertible()); // Checking Invertibility

    VecType x = A->partialPivLu().solve(*b);
    printf("\n");
    printf("[Host]");
    print_solution(x,DIM);

    #if defined(USE_OPENACC)
    #pragma acc data copyin(A[0:DIM*DIM],b[0:DIM])
    #endif
    #if defined(USE_OPENMP)
    #pragma omp target data map(to:A[0:DIM*DIM],b[0:DIM])
    #endif
    {
        #if defined(USE_OPENACC)
        #pragma acc kernels present(A,b)
        #endif
        #if defined(USE_OPENMP)
        #pragma omp target
        #endif
        {
            solve_offload(A, b, DIM);
            // We need to wrap it around `omp declare target` or
            // `acc routine seq` to work!
            // A->partialPivLu().solve(*b);
        }

        #if defined(USE_OPENACC)
        #pragma acc host_data use_device(A,b)
        #endif
        #if defined(USE_OPENMP)
        #pragma omp target data use_device_ptr(A,b)
        #endif
        {
            solve_cuda(A, b, DIM);
        }
    }

    return 0;
}
