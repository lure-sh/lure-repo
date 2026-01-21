name="vc4cl-git"
version="0.0.0"
release="1"
desc="OpenCL 1.2 implementation for the VideoCore IV GPU (Raspberry Pi)"
homepage="https://github.com/doe300/VC4CL"
maintainer="Foad Sojoodi Farimani <f.s.farimani@gmail.com>"
architectures=("arm64" "arm")
license=("MIT")
provides=("opencl-driver" "vc4cl")

# Runtime dependencies
deps=("vc4c" "ocl-icd-libopencl1")

# Build dependencies
build_deps=(
    "git"
    "cmake"
    "build-essential"
    "pkg-config"
    "clang"
    "llvm"
    "opencl-headers"
    "ocl-icd-opencl-dev"
    "vc4c"
    "ocl-icd-dev"
)

sources=("git+https://github.com/doe300/VC4CL.git")
checksums=("SKIP")

version() {
    cd "$srcdir/VC4CL"
    # Debian requires version to start with a digit
    printf "0.0.0.r%s.%s" "$(git rev-list --count HEAD)" "$(git rev-parse --short HEAD)"
}

prepare() {
    # Generate the ICD file for the OpenCL loader
    echo "/usr/lib/libVC4CL.so" > "$srcdir/VC4CL.icd"
}

build() {
    cd "$srcdir/VC4CL"
    mkdir -p build
    cd build
    
    cmake .. \
        -DCMAKE_INSTALL_PREFIX=/usr \
        -DCMAKE_BUILD_TYPE=Release \
        -DBUILD_TESTING=OFF \
        -DBUILD_ICD=ON \
        -DINCLUDE_COMPILER=ON
    
    make -j1
}

package() {
    cd "$srcdir/VC4CL/build"
    make DESTDIR="$pkgdir" install
    
    # Install ICD file for OpenCL loader discovery
    install -Dm644 "$srcdir/VC4CL.icd" "$pkgdir/etc/OpenCL/vendors/VC4CL.icd"
}
