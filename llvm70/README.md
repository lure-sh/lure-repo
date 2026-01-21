# llvm70

LLVM 7.0.1 compiler toolchain for LURE, installed under `/opt/llvm70`.

## Description

This package provides LLVM 7.0.1, an older but stable version required by [beignet](https://github.com/intel/beignet) for Intel IvyBridge/Haswell OpenCL support. Modern LLVM versions (11+) are incompatible with beignet due to API changes.

## Installation

```bash
lure install llvm70
```

## Build Dependencies

- cmake, ninja-build, libffi-dev, libedit-dev, libncurses-dev, libxml2-dev, binutils-dev

## Files

Installs to `/opt/llvm70/` to avoid conflicts with system LLVM.

## Related Packages

- **clang70** - Clang 7.0.1 frontend (requires this package)
- **beignet-git** - Intel OpenCL driver (requires clang70)

## Build Time

Expect 30-60+ minutes depending on CPU.

## License

NCSA
