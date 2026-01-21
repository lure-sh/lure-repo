# vc4cl-git

LURE package for the VC4CL OpenCL runtime.

## Description

VC4CL is an implementation of the OpenCL 1.2 standard for the VideoCore IV GPU found in Raspberry Pi 1-3 models.

**WARNING**: VC4CL does NOT work on Raspberry Pi 4/5 (different GPU architecture).

## Dependencies

- Build: `git`, `cmake`, `build-essential`, `pkg-config`, `clang`, `llvm`, `opencl-headers`, `ocl-icd-opencl-dev`, `vc4c`
- Runtime: `vc4c`, `ocl-icd-libopencl1`

## Installation

```bash
# Ensure vc4c-stdlib-git and vc4c-git are installed first
lure build
sudo apt install ./vc4cl-git_*.deb
```

## Lessons Learned

### Critical: 64-bit ARM (aarch64) is NOT supported

VC4CL has memory alignment bugs that cause `SIGBUS` (Bus error) crashes on 64-bit Raspberry Pi OS. The `v3d_info` tool works, but any OpenCL program (including `clinfo`) will crash.

**Workarounds**:
1. Use 32-bit Raspberry Pi OS (recommended)
2. Add `arm_64bit=0` to `/boot/config.txt` to force 32-bit kernel
3. Use POCL (`sudo apt install pocl-opencl-icd`) for CPU-based OpenCL

### Legacy library paths

VC4CL looks for `libbcm_host.so` in `/opt/vc/lib/` (legacy location). On modern Raspberry Pi OS, create symlinks:

```bash
sudo mkdir -p /opt/vc/lib
sudo ln -s /usr/lib/aarch64-linux-gnu/libbcm_host.so.0 /opt/vc/lib/libbcm_host.so
sudo ln -s /usr/lib/aarch64-linux-gnu/libvcos.so.0 /opt/vc/lib/libvcos.so
sudo ln -s /usr/lib/aarch64-linux-gnu/libvchiq_arm.so.0 /opt/vc/lib/libvchiq_arm.so
```

### ICD file

The package installs `/etc/OpenCL/vendors/VC4CL.icd` pointing to `/usr/lib/libVC4CL.so`.

### Other notes

- Memory constraints: Use `make -j1` on Pi 3B to avoid OOM
- Debian version format: Version must start with a digit (`0.0.0.r%s.%s`)

## Verification

```bash
# Check hardware info (works on 64-bit)
sudo v3d_info

# Check OpenCL (requires 32-bit kernel)
sudo clinfo
```

## Related Packages

- [vc4c-stdlib-git](../vc4c-stdlib-git/) - Standard library headers
- [vc4c-git](../vc4c-git/) - The compiler
- [clinfo-git](../clinfo-git/) - OpenCL info tool

## Upstream

- https://github.com/doe300/VC4CL
- Open issues: [#97 support arm64](https://github.com/doe300/VC4CL/issues/97), [#108 Support 64-bit Bullseye](https://github.com/doe300/VC4CL/issues/108)
