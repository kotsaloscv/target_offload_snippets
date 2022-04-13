rm test*_ *.o *.a

# clang
module purge
module load unstable llvm gcc

CXX=clang++
CXXFLAGS="-fopenmp -fopenmp-targets=nvptx64-nvidia-cuda -g -O2"
${CXX} ${CXXFLAGS} -c test.cpp
ar cq libtest.a test.o
${CXX} ${CXXFLAGS} -o test1_ main.cpp -L. -ltest
${CXX} ${CXXFLAGS} -o test2_ main.cpp test.o

echo "*****>clang"
if [ -f test1_ ] ; then ./test1_; echo $?; fi
if [ -f test2_ ] ; then ./test2_; echo $?; fi
rm test*_ *.o *.a
echo "*****<"

# nvhpc
module purge
module load unstable gcc nvhpc cuda

CXX=nvc++
CXXFLAGS="-mp=gpu -g -O2"
${CXX} ${CXXFLAGS} -c test.cpp
ar cq libtest.a test.o
${CXX} ${CXXFLAGS} -o test1_ main.cpp -L. -ltest
${CXX} ${CXXFLAGS} -o test2_ main.cpp test.o

echo "*****>nvhpc"
if [ -f test1_ ] ; then ./test1_; echo $?; fi
if [ -f test2_ ] ; then ./test2_; echo $?; fi
rm test*_ *.o *.a
echo "*****<"

# intel
module purge
module load unstable intel-oneapi-compilers

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
