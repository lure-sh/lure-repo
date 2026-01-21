# vc4c-git

LURE package for the VC4C OpenCL compiler.

## Description

VC4C is a compiler that converts OpenCL kernels into machine code for the VideoCore IV GPU found in Raspberry Pi 1-3 models.

## Dependencies

- Build: `git`, `cmake`, `build-essential`, `clang`, `llvm`, `llvm-dev`, `libclang-dev`, `llvm-spirv-14`, `spirv-tools`, `pkg-config`, `vc4c-stdlib`
- Runtime: `vc4c-stdlib`

## Installation

```bash
# Ensure vc4c-stdlib-git is installed first
lure build
sudo apt install ./vc4c-git_*.deb
```

## Lessons Learned

1. **Memory constraints**: On Raspberry Pi 3B (1GB RAM), parallel compilation causes OOM. Changed `make -j$(nproc)` to `make -j1` to avoid crashes.

2. **SPIRV package naming**: Debian Bookworm uses versioned package names. Use `llvm-spirv-14` instead of the non-existent `libllvm-spirv-dev`.

3. **Precompilation warning**: The build shows an error about `/VC4CLStdLib.h` during precompilation - this is non-fatal and the package installs correctly.

4. **Debian version format**: Version must start with a digit (`0.0.0.r%s.%s`).

## Related Packages

- [vc4c-stdlib-git](../vc4c-stdlib-git/) - Required dependency
- [vc4cl-git](../vc4cl-git/) - The OpenCL runtime (depends on this)

## Upstream

- https://github.com/doe300/VC4C
