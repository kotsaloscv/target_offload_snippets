#include "api.h"

__host__ __device__
void print_solution(VecType x, int dim)
{
    printf("\n");
    printf("x = ");
    for (int i = 0; i < dim; i++)
        printf("%.3f ", x(i));
    printf("\n\n");
}

__global__
void cuda_kernel(MatType *A, VecType *b, int dim)
{
    VecType x = A->partialPivLu().solve(*b);
    printf("[CUDA]");
    print_solution(x,dim);
}

void solve_cuda(MatType *A, VecType *b, int dim)
{
    cuda_kernel<<<1, 1>>>(A, b, dim);
    cudaDeviceSynchronize();
}

__device__ 
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
