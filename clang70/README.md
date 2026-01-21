# clang70

Clang 7.0.1 C/C++/Objective-C compiler for LURE, installed under `/opt/llvm70`.

## Description

This package provides Clang 7.0.1, the C language family frontend for LLVM 7.0. Required by [beignet](https://github.com/intel/beignet) to compile OpenCL kernels for Intel IvyBridge/Haswell GPUs.

## Installation

```bash
lure install clang70
```

Automatically installs `llvm70` as a dependency.

## Build Dependencies

- cmake, ninja-build, libffi-dev, libedit-dev, libncurses-dev, libxml2-dev
- llvm70 (runtime dependency, must be installed first)

## Files

Installs to `/opt/llvm70/` alongside LLVM 7.0.

## Related Packages

- **llvm70** - LLVM 7.0.1 backend (dependency)
- **beignet-git** - Intel OpenCL driver (requires this package)

## Build Time

Expect 15-30 minutes depending on CPU.

## License

NCSA
