# beignet-git

Intel OpenCL implementation for IvyBridge & Haswell iGPUs.

## Description

Beignet is an open source OpenCL implementation for Intel Gen7/Gen7.5 GPUs (IvyBridge, Haswell). This package builds from git master with LLVM 7.0.

**Supported Hardware:**
- Intel HD Graphics 4000/4200/4400/4600 (Haswell)
- Intel HD Graphics 2500/4000 (IvyBridge)

## Installation

```bash
# Install all dependencies (builds llvm70 and clang70 first)
lure install beignet-git
```

## Verification

```bash
clinfo | grep -i "Intel Gen"
```

Expected output:
```
Platform Name                                   Intel Gen OCL Driver
Device Name                                     Intel(R) HD Graphics Haswell ...
```

## Dependencies

- **clang70** - Clang 7.0.1 (automatically pulls in llvm70)
- ocl-icd-libopencl1, libgl1, libdrm2

## Why LLVM 7.0?

Beignet was abandoned by Intel and only supports LLVM 3.9-7.0. Modern LLVM versions have incompatible API changes. This package uses a self-contained LLVM 7.0 installation in `/opt/llvm70/`.

## Alternatives

- **rusticl** (Mesa 24.0+) - Modern OpenCL for Intel GPUs, actively maintained
- **intel-compute-runtime** - For newer Intel GPUs (Broadwell+)

## License

LGPL-2.1-or-later
