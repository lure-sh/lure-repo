name="vc4c-stdlib-git"
version="0.0.0"
release="1"
desc="Standard library for the VC4C compiler (VideoCore IV)"
homepage="https://github.com/doe300/VC4CLStdLib"
maintainer="Foad Sojoodi Farimani <f.s.farimani@gmail.com>"
architectures=("arm64" "arm")
license=("MIT")
provides=("vc4c-stdlib")

# Build dependencies - all from standard repos
build_deps=("git" "cmake" "build-essential" "clang" "llvm" "spirv-tools")

sources=("git+https://github.com/doe300/VC4CLStdLib.git")
checksums=("SKIP")

version() {
    cd "$srcdir/VC4CLStdLib"
    # Debian requires version to start with a digit
    printf "0.0.0.r%s.%s" "$(git rev-list --count HEAD)" "$(git rev-parse --short HEAD)"
}

build() {
    cd "$srcdir/VC4CLStdLib"
    mkdir -p build
    cd build
    
    cmake .. \
        -DCMAKE_INSTALL_PREFIX=/usr \
        -DCMAKE_BUILD_TYPE=Release
    
    make -j$(nproc)
}

package() {
    cd "$srcdir/VC4CLStdLib/build"
    make DESTDIR="$pkgdir" install
}
