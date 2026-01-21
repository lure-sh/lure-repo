name="vc4c-git"
version="0.0.0"
release="1"
desc="Compiler for the VC4CL OpenCL implementation (VideoCore IV)"
homepage="https://github.com/doe300/VC4C"
maintainer="Foad Sojoodi Farimani <f.s.farimani@gmail.com>"
architectures=("arm64" "arm")
license=("MIT")
provides=("vc4c")

# Runtime dependencies
deps=("vc4c-stdlib")

# Build dependencies - use LLVM 14 for C++14 compatibility
build_deps=(
    "git"
    "cmake"
    "build-essential"
    "llvm-14"
    "llvm-14-dev"
    "libclang-14-dev"
    "llvm-spirv-14"
    "spirv-tools"
    "pkg-config"
    "vc4c-stdlib"
)

sources=("git+https://github.com/doe300/VC4C.git")
checksums=("SKIP")

version() {
    cd "$srcdir/VC4C"
    printf "0.0.0.r%s.%s" "$(git rev-list --count HEAD)" "$(git rev-parse --short HEAD)"
}

build() {
    cd "$srcdir/VC4C"
    mkdir -p build
    cd build
    
    # Use GCC but with LLVM 14 libraries
    cmake .. \
        -DCMAKE_INSTALL_PREFIX=/usr \
        -DCMAKE_BUILD_TYPE=Release \
        -DBUILD_TESTING=OFF \
        -DVC4CL_STDLIB_DIR=/usr/include/vc4cl-stdlib \
        -DVC4CL_STDLIB_PRECOMPILE=OFF \
        -DLLVM_CONFIG_PATH=/usr/bin/llvm-config-14
    
    make -j1
}

package() {
    cd "$srcdir/VC4C/build"
    make DESTDIR="$pkgdir" install
}
