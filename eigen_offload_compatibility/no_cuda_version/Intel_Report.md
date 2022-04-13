We follow the README and get the following compilation error:

```
344 warnings generated.
LLVM ERROR: Type mismatch in constant table!
PLEASE submit a bug report to https://software.intel.com/en-us/support/priority-support and include the crash backtrace.
Stack dump:
0.      Program arguments: /glob/development-tools/versions/oneapi/2022.1.2/oneapi/compiler/2022.0.2/linux/bin-llvm/llvm-link /tmp/eigen-660a10.bc /tmp/libomp-spirvdevicertl-0fd3f3.o -o /tmp/spir64-linkomp-2d06f8.bc --suppress-warnings
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
/glob/development-tools/versions/oneapi/2022.1.2/oneapi/compiler/2022.0.2/linux/bin-llvm/llvm-link(+0x311bba)[0x55ecac9b4bba]
/glob/development-tools/versions/oneapi/2022.1.2/oneapi/compiler/2022.0.2/linux/bin-llvm/llvm-link(+0x30fd90)[0x55ecac9b2d90]
/glob/development-tools/versions/oneapi/2022.1.2/oneapi/compiler/2022.0.2/linux/bin-llvm/llvm-link(+0x31201d)[0x55ecac9b501d]
/lib/x86_64-linux-gnu/libpthread.so.0(+0x12890)[0x7f2ad16b2890]
/lib/x86_64-linux-gnu/libc.so.6(gsignal+0xc7)[0x7f2ad12ede97]
/lib/x86_64-linux-gnu/libc.so.6(abort+0x141)[0x7f2ad12ef801]
/glob/development-tools/versions/oneapi/2022.1.2/oneapi/compiler/2022.0.2/linux/bin-llvm/llvm-link(+0x2e62d4)[0x55ecac9892d4]
/glob/development-tools/versions/oneapi/2022.1.2/oneapi/compiler/2022.0.2/linux/bin-llvm/llvm-link(+0x2e6165)[0x55ecac989165]
/glob/development-tools/versions/oneapi/2022.1.2/oneapi/compiler/2022.0.2/linux/bin-llvm/llvm-link(+0x1c3792)[0x55ecac866792]
/glob/development-tools/versions/oneapi/2022.1.2/oneapi/compiler/2022.0.2/linux/bin-llvm/llvm-link(+0x1a01a5)[0x55ecac8431a5]
/glob/development-tools/versions/oneapi/2022.1.2/oneapi/compiler/2022.0.2/linux/bin-llvm/llvm-link(+0x197d13)[0x55ecac83ad13]
/glob/development-tools/versions/oneapi/2022.1.2/oneapi/compiler/2022.0.2/linux/bin-llvm/llvm-link(+0x196a62)[0x55ecac839a62]
/glob/development-tools/versions/oneapi/2022.1.2/oneapi/compiler/2022.0.2/linux/bin-llvm/llvm-link(+0x27e125)[0x55ecac921125]
/glob/development-tools/versions/oneapi/2022.1.2/oneapi/compiler/2022.0.2/linux/bin-llvm/llvm-link(+0x2530d0)[0x55ecac8f60d0]
/glob/development-tools/versions/oneapi/2022.1.2/oneapi/compiler/2022.0.2/linux/bin-llvm/llvm-link(+0x2b767c)[0x55ecac95a67c]
/glob/development-tools/versions/oneapi/2022.1.2/oneapi/compiler/2022.0.2/linux/bin-llvm/llvm-link(+0x2b4e32)[0x55ecac957e32]
/glob/development-tools/versions/oneapi/2022.1.2/oneapi/compiler/2022.0.2/linux/bin-llvm/llvm-link(+0x314454)[0x55ecac9b7454]
/glob/development-tools/versions/oneapi/2022.1.2/oneapi/compiler/2022.0.2/linux/bin-llvm/llvm-link(+0x314df7)[0x55ecac9b7df7]
/glob/development-tools/versions/oneapi/2022.1.2/oneapi/compiler/2022.0.2/linux/bin-llvm/llvm-link(+0x3156dc)[0x55ecac9b86dc]
/glob/development-tools/versions/oneapi/2022.1.2/oneapi/compiler/2022.0.2/linux/bin-llvm/llvm-link(+0x314009)[0x55ecac9b7009]
/glob/development-tools/versions/oneapi/2022.1.2/oneapi/compiler/2022.0.2/linux/bin-llvm/llvm-link(+0x31413a)[0x55ecac9b713a]
/glob/development-tools/versions/oneapi/2022.1.2/oneapi/compiler/2022.0.2/linux/bin-llvm/llvm-link(+0x2b2e31)[0x55ecac955e31]
/glob/development-tools/versions/oneapi/2022.1.2/oneapi/compiler/2022.0.2/linux/bin-llvm/llvm-link(+0x2b24dc)[0x55ecac9554dc]
/glob/development-tools/versions/oneapi/2022.1.2/oneapi/compiler/2022.0.2/linux/bin-llvm/llvm-link(+0x2bce3f)[0x55ecac95fe3f]
/glob/development-tools/versions/oneapi/2022.1.2/oneapi/compiler/2022.0.2/linux/bin-llvm/llvm-link(+0x2bc458)[0x55ecac95f458]
/glob/development-tools/versions/oneapi/2022.1.2/oneapi/compiler/2022.0.2/linux/bin-llvm/llvm-link(+0x18e63c)[0x55ecac83163c]
/glob/development-tools/versions/oneapi/2022.1.2/oneapi/compiler/2022.0.2/linux/bin-llvm/llvm-link(+0x18c1f0)[0x55ecac82f1f0]
/lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xe7)[0x7f2ad12d0b97]
/glob/development-tools/versions/oneapi/2022.1.2/oneapi/compiler/2022.0.2/linux/bin-llvm/llvm-link(+0x18b6a9)[0x55ecac82e6a9]
clang++: error: unable to execute command: Aborted
clang++: error: sycl-link command failed due to signal (use -v to see invocation)
Intel(R) oneAPI DPC++/C++ Compiler 2022.0.0 (2022.0.0.20211123)
Target: x86_64-unknown-linux-gnu
Thread model: posix
InstalledDir: /glob/development-tools/versions/oneapi/2022.1.2/oneapi/compiler/2022.0.2/linux/bin-llvm
clang++: note: diagnostic msg: Error generating preprocessed source(s).
```
