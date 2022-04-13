1. Intel devcloud: `qsub -I -l nodes=1:gpu:ppn=2 -d .`
2. 
```
export OMP_TARGET_OFFLOAD=MANDATORY

CXX=icpx
CXXFLAGS="-qopenmp -fopenmp-targets=spir64 -g -O2"
${CXX} ${CXXFLAGS} -c test.cpp
ar cq libtest.a test.o
${CXX} ${CXXFLAGS} -o test1_ main.cpp -L. -ltest
${CXX} ${CXXFLAGS} -o test2_ main.cpp test.o

echo "*****>intel"
if [ -f test1_ ] ; then ./test1_; echo $?; fi
if [ -f test2_ ] ; then ./test2_; echo $?; fi
rm test*_ *.o *.a
echo "*****<"
```
Output:
```
*****>intel
--> 0 
--> 1 
--> 2 
--> 3 
--> 4 
LEVEL0 error: Failed to invoke deleted kernel.
Libomptarget error: Executing target region abort target.
Libomptarget error: Run with
Libomptarget error: LIBOMPTARGET_DEBUG=1 to display basic debug information.
Libomptarget error: LIBOMPTARGET_DEBUG=2 to display calls to the compute runtime.
Libomptarget error: LIBOMPTARGET_INFO=4 to dump host-target pointer mappings.
unknown:11:11: Libomptarget fatal error 1: failure of target construct while offloading is mandatory
./test.sh: line 13: 3572577 Aborted                 ./test1_
134
--> 0 
--> 1 
--> 2 
--> 3 
--> 4 
42
*****<
```
Both tests are wrong, i.e. the output should be 24.