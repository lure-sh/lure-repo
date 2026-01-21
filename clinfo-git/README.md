# clinfo-git

LURE package for clinfo - OpenCL platform and device information tool.

## Description

clinfo prints all known information about all available OpenCL platforms and devices in the system.

## Dependencies

- Build: `git`, `build-essential`, `opencl-headers`, `ocl-icd-opencl-dev`
- Runtime: `ocl-icd-libopencl1`

## Installation

```bash
lure build
sudo apt install ./clinfo-git_*.deb
```

## Usage

```bash
clinfo           # List all OpenCL platforms and devices
clinfo -l        # Short listing
clinfo --json    # JSON output
```

## Lessons Learned

1. **Version function**: The AUR PKGBUILD uses `git describe --long --tags` which may fail if no tags exist. Added fallback to commit-based versioning.

2. **Bash local variables**: LURE's shell may not support `local` keyword in all contexts. The warning `local: can only be used in a function` appears but doesn't affect the build.

## Notes

This is a generic OpenCL tool that works with any OpenCL implementation (VC4CL, POCL, Mesa Clover, etc.).

## Upstream

- https://github.com/Oblomov/clinfo
