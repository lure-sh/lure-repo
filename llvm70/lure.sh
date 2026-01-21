name="llvm70"
version="7.0.1"
release="1"
desc="LLVM compiler toolchain, version 7.0 (installed under /opt/llvm70)"
homepage="https://llvm.org/"
maintainer="Your Name <email@example.com>"
architectures=("amd64")
license=("NCSA")

# Runtime dependencies
deps=("libedit2" "libxml2" "python3")

# Build dependencies - Debian/Ubuntu package names
build_deps=("cmake" "ninja-build" "libffi-dev" "libedit-dev" "libncurses-dev" "libxml2-dev" "pkg-config" "binutils-dev")

sources=(
    "https://releases.llvm.org/${version}/llvm-${version}.src.tar.xz"
)

checksums=(
    "a38dfc4db47102ec79dcc2aa61e93722c5f6f06f0a961073bd84b78fb949419b"
)

build() {
    cd "$srcdir/llvm-${version}.src"
    mkdir -p build
    cd build

    # Get FFI include directory
    local FFI_INCLUDE
    FFI_INCLUDE="$(pkg-config --variable=includedir libffi)"

    cmake .. -G Ninja \
        -DCMAKE_BUILD_TYPE=Release \
        -DCMAKE_INSTALL_PREFIX=/opt/llvm70 \
        -DPYTHON_EXECUTABLE=/usr/bin/python3 \
        -DLLVM_HOST_TRIPLE=x86_64-pc-linux-gnu \
        -DLLVM_BUILD_LLVM_DYLIB=ON \
        -DLLVM_LINK_LLVM_DYLIB=ON \
        -DLLVM_INSTALL_UTILS=ON \
        -DLLVM_ENABLE_RTTI=ON \
        -DLLVM_ENABLE_FFI=ON \
        -DLLVM_BUILD_TESTS=OFF \
        -DLLVM_BUILD_DOCS=OFF \
        -DLLVM_ENABLE_SPHINX=OFF \
        -DLLVM_ENABLE_DOXYGEN=OFF \
        -DLLVM_ENABLE_BINDINGS=OFF \
        -DSPHINX_WARNINGS_AS_ERRORS=OFF \
        -DFFI_INCLUDE_DIR="$FFI_INCLUDE" \
        -DLLVM_BINUTILS_INCDIR=/usr/include

    ninja
}

package() {
    cd "$srcdir/llvm-${version}.src/build"
    DESTDIR="$pkgdir" ninja install

    # Install license
    install -Dm644 ../LICENSE.TXT "$pkgdir/usr/share/licenses/$name/LICENSE"
}
