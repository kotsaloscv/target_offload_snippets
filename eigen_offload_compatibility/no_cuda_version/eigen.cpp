#include <stdio.h>
#include "Eigen/Core"
#include "Eigen/Dense"
#include "Eigen/LU"
#include <random>

// for DIM 17 and above : stack size issues
#define DIM 16

using namespace Eigen;
using MatType = Matrix<double, DIM, DIM>;
using VecType = Matrix<double, DIM, 1>;

void print_solution(VecType x, int dim)
{
    printf("\n");
    printf("x = ");
    for (int i = 0; i < dim; i++)
        printf("%.3f ", x(i));
    printf("\n\n");
}

#if defined(USE_OPENACC)
#pragma acc routine seq
#endif
#if defined(USE_OPENMP)
#pragma omp declare target
#endif
void solve_offload(MatType *A, VecType *b, int dim)
{
    VecType x = A->partialPivLu().solve(*b);
    #if defined(USE_OPENACC)
    printf("[OpenACC]");
    #endif
    #if defined(USE_OPENMP)
    printf("[OpenMP]");
    #endif
    print_solution(x,dim);
}
#if defined(USE_OPENMP)
#pragma omp end declare target
#endif


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
    }

    return 0;
}
