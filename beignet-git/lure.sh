name="beignet-git"
version="0.0.0"
release="1"
desc="Open source OpenCL implementation for Intel IvyBridge & Haswell iGPUs"
homepage="https://01.org/beignet"
maintainer="Your Name <email@example.com>"
architectures=("amd64")
license=("LGPL-2.1-or-later")
provides=("beignet" "opencl-driver")
conflicts=("beignet")

# Runtime Dependencies
deps=("ocl-icd-libopencl1" "libgl1" "libdrm2" "clang70")

# Build Dependencies
# Note: We use clang70 which depends on llvm70, providing LLVM 7.0 in /opt/llvm70
build_deps=("git" "cmake" "ninja-build" "pkg-config" "python3" "clang70" "ocl-icd-opencl-dev" "opencl-headers" "mesa-common-dev" "libgl1-mesa-dev" "libdrm-dev" "libx11-dev" "libxext-dev" "libxfixes-dev")

# LURE does NOT support PKGBUILD's "filename::url" rename syntax.
# The filename is derived from the URL path.
sources=(
    "git+https://github.com/intel/beignet.git"
    "https://raw.githubusercontent.com/michaellass/AUR/master/beignet-git/GBE-let-GenRegister-reg-never-return-uninitialized-m.patch"
    "https://raw.githubusercontent.com/michaellass/AUR/master/beignet-git/utests_add_limits.patch"
)
checksums=("SKIP" "SKIP" "SKIP")

version() {
    cd "$srcdir/beignet"
    git describe --long --tags | sed 's/^Release_v//;s/-/.r/;s/-/./'
}

prepare() {
    cd "$srcdir/beignet"

    # PKGBUILD Revert: "Static linking leads to build failure due to the gbe compiler still using shared libs"
    git revert -n 1bd0d252d733

    # Apply patches - use FULL filenames as downloaded by LURE
    patch -p1 < "$srcdir/GBE-let-GenRegister-reg-never-return-uninitialized-m.patch"
    patch -p1 < "$srcdir/utests_add_limits.patch"
    
    # Note: We do NOT need llvm10.patch when using LLVM 7.0
}

build() {
    cd "$srcdir/beignet"
    mkdir -p build
    cd build

    # Use LLVM 7.0 from /opt/llvm70
    export PATH=/opt/llvm70/bin:$PATH

    cmake .. -G Ninja \
        -DCMAKE_INSTALL_PREFIX=/usr \
        -DCMAKE_INSTALL_LIBDIR=/usr/lib/x86_64-linux-gnu \
        -DCMAKE_BUILD_TYPE=Release \
        -DCMAKE_INSTALL_RPATH_USE_LINK_PATH=TRUE \
        -DLLVM_INSTALL_DIR=/opt/llvm70/bin

    ninja
}

package() {
    cd "$srcdir/beignet/build"

    # Install
    DESTDIR="$pkgdir" ninja install

    # Cleanup headers provided by opencl-headers package (as per PKGBUILD)
    if [ -d "${pkgdir}/usr/include/CL" ]; then
        cd "${pkgdir}/usr/include/CL"
        rm -f cl.h cl_d3d10.h cl_d3d11.h cl_dx9_media_sharing.h cl_egl.h cl_ext.h \
              cl_gl.h cl_gl_ext.h cl_platform.h opencl.h
    fi
}
