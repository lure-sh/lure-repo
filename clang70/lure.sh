name="clang70"
version="7.0.1"
release="1"
desc="C language family frontend for LLVM, version 7.0 (installed under /opt/llvm70)"
homepage="https://llvm.org/"
maintainer="Your Name <email@example.com>"
architectures=("amd64")
license=("NCSA")

# Runtime dependencies - clang70 needs llvm70
deps=("llvm70" "python3")

# Build dependencies - Debian/Ubuntu package names
build_deps=("cmake" "ninja-build" "libffi-dev" "libedit-dev" "libncurses-dev" "libxml2-dev")

sources=(
    "https://releases.llvm.org/${version}/llvm-${version}.src.tar.xz"
    "https://releases.llvm.org/${version}/cfe-${version}.src.tar.xz"
)

checksums=(
    "a38dfc4db47102ec79dcc2aa61e93722c5f6f06f0a961073bd84b78fb949419b"
    "a45b62dde5d7d5fdcdfa876b0af92f164d434b06e9e89b5d0b1cbc65dfe3f418"
)

build() {
    cd "$srcdir/cfe-${version}.src"
    mkdir -p build
    cd build

    # Add llvm70 to PATH so cmake can find llvm-config
    export PATH=/opt/llvm70/bin:$PATH

    cmake .. -G Ninja \
        -DCMAKE_BUILD_TYPE=Release \
        -DCMAKE_INSTALL_PREFIX=/opt/llvm70 \
        -DPYTHON_EXECUTABLE=/usr/bin/python3 \
        -DBUILD_SHARED_LIBS=ON \
        -DLLVM_LINK_LLVM_DYLIB=ON \
        -DLLVM_ENABLE_RTTI=ON \
        -DLLVM_BUILD_TESTS=OFF \
        -DLLVM_INCLUDE_DOCS=OFF \
        -DLLVM_BUILD_DOCS=OFF \
        -DLLVM_ENABLE_SPHINX=OFF \
        -DSPHINX_WARNINGS_AS_ERRORS=OFF \
        -DLLVM_MAIN_SRC_DIR="$srcdir/llvm-${version}.src"

    ninja
}

package() {
    cd "$srcdir/cfe-${version}.src/build"
    DESTDIR="$pkgdir" ninja install

    # Install license
    install -Dm644 ../LICENSE.TXT "$pkgdir/usr/share/licenses/$name/LICENSE"
}
