# vc4c-stdlib-git

LURE package for the VC4CL Standard Library headers.

## Description

VC4CLStdLib is the platform-specific implementation of the OpenCL C standard library for the VideoCore IV GPU found in Raspberry Pi 1-3 models.

## Dependencies

- Build: `git`, `cmake`, `build-essential`, `clang`, `llvm`, `spirv-tools`
- Runtime: none (header-only)

## Installation

```bash
lure build
sudo apt install ./vc4c-stdlib-git_*.deb
```

## Lessons Learned

1. **Debian version format**: The `version()` function must produce versions starting with a digit. Changed from `r%s.%s` to `0.0.0.r%s.%s` to comply with Debian policy.

2. **Build order**: This package must be installed first, before `vc4c-git` and `vc4cl-git`.

## Related Packages

- [vc4c-git](../vc4c-git/) - The VC4C compiler (depends on this)
- [vc4cl-git](../vc4cl-git/) - The OpenCL runtime (depends on vc4c)

## Upstream

- https://github.com/doe300/VC4CLStdLib
