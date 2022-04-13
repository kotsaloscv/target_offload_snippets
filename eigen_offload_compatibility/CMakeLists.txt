cmake_minimum_required(VERSION 3.8 FATAL_ERROR)

project(eigen_offload_proj LANGUAGES CXX CUDA)

option(USE_OPENACC ON)
option(USE_OPENMP OFF)

if(USE_OPENACC)
    add_definitions(-DUSE_OPENACC)
    set(OFFLOAD_FLAGS -DEIGEN_DONT_VECTORIZE=1 -acc)
endif()
if(USE_OPENMP)
    add_definitions(-DUSE_OPENMP)
    set(OFFLOAD_FLAGS -DEIGEN_DONT_VECTORIZE=1 -mp=gpu -acc)
endif()
set(CUDA_FLAGS --expt-relaxed-constexpr)

include_directories("eigen")

set(CMAKE_CUDA_RUNTIME_LIBRARY None)

add_library(api OBJECT api.cu)
set_target_properties(api PROPERTIES CUDA_SEPARABLE_COMPILATION ON)
target_compile_options(api PUBLIC $<$<COMPILE_LANGUAGE:CUDA>:${CUDA_FLAGS}>)

add_executable(eigen_offload eigen.cpp)
target_link_libraries(eigen_offload api)
target_compile_options(eigen_offload PUBLIC $<$<COMPILE_LANGUAGE:CXX>:${OFFLOAD_FLAGS}>)
target_link_options(eigen_offload PUBLIC $<$<COMPILE_LANGUAGE:CXX>:${OFFLOAD_FLAGS} -cuda>)
