1. Intel devcloud: `qsub -I -l nodes=1:gpu:ppn=2 -d .`
2. 
```
export OMP_TARGET_OFFLOAD=MANDATORY

CXX=icpx
CXXFLAGS="-qopenmp -fopenmp-targets=spir64"
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
./test.sh: line 13: 3572216 Segmentation fault      ./test1_
139
42
*****<
```
Both tests are wrong, i.e. the output should be 24.