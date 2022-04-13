1. Intel devcloud: `qsub -I -l nodes=1:gpu:ppn=2 -d .`
2. `icpx -qopenmp -fopenmp-targets=spir64 openmp_target_offload_clause_ordering.cpp`
3. `export OMP_TARGET_OFFLOAD=MANDATORY`
4. `./a.out`
    - Error:
        ```
        ptr=0xdeadbeef
        Libomptarget error: Executing target region abort target.
        Libomptarget error: Run with
        Libomptarget error: LIBOMPTARGET_DEBUG=1 to display basic debug information.
        Libomptarget error: LIBOMPTARGET_DEBUG=2 to display calls to the compute runtime.
        Libomptarget error: LIBOMPTARGET_INFO=4 to dump host-target pointer mappings.
        Libomptarget error: Source location information not present. Compile with -g or -gline-tables-only.
        Libomptarget fatal error 1: failure of target construct while offloading is mandatory
        Aborted
        ```
