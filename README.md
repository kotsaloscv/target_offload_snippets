# target_offload_snippets
Various code snippets with openmp/openacc offloading

 **case studies** | **nvhpc/22.3** | **llvm/13.0.0** | **Intel oneAPI Compiler 2022.0.0** 
:---:|:---:|:---:|:---:
 eigen_offload_compatibility |  |  | BUG REPORT  
 implicit_declare | BUG REPORT (resolved with O2) | OK | OK  
 openacc_atomics | SOLVED with latest NVHPC | - | -  
 openacc_shared_lib:example1 | IN PROGRESS | - | -  
 openacc_shared_lib:example2 | IN PROGRESS | - | -  
 openacc_shared_lib:example3 | SOLVED | - | -  
 openmp_atomics | BUG REPORT | OK | OK  
 openmp_breaks_openacc_code | SOLVED with -cuda flag | OK | OK  
 openmp_clause_ordering | SOLVED with latest NVHPC | OK | BUG REPORT  
 openmp_llvm: scenario1 | OK | REPORTED | BUG REPORT  
 openmp_llvm: scenario2 | OK | REPORTED | BUG REPORT  
 openmp_shared_lib | Only with OpenACC | OK | OK  
