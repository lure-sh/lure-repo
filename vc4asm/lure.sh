name="vc4asm"
version="0.3"
release="1"
desc="Macro assembler for Broadcom VideoCore IV aka Raspberry Pi GPU"
homepage="https://maazl.de/project/vc4asm/doc/index.html"
maintainer="Your Name <email@example.com>"
architectures=("all")
license=("GPL-3.0-or-later")
provides=("vc4asm")
conflicts=("vc4asm")

# Build Dependencies
build_deps=("cmake" "build-essential")

# Runtime Dependencies (minimal)
deps=()

# Sources: tarball + patch from GitHub raw URL
# The patch file will be downloaded to $srcdir with filename derived from URL
sources=(
    "https://github.com/maazl/vc4asm/archive/refs/tags/V${version}.tar.gz"
    "https://github.com/maazl/vc4asm/commit/ff16f635b07e14b07c1de69bf322e3bf7feecd93.patch"
)
checksums=(
    "sha256:f712fb27eb1b7d46b75db298fd50bb62905ccbdd7c0c7d27728596c496f031c2"
    "sha256:aac41ac1f58e9c08cef7b67c9e1a8df33c53acb951be003597bc0f2b9a9621b6"
)

prepare() {
    cd "$srcdir/vc4asm-${version}"

    # Apply GCC 9+ compatibility patch
    # The patch is downloaded to $srcdir with the commit hash as filename
    patch -p1 < "$srcdir/ff16f635b07e14b07c1de69bf322e3bf7feecd93.patch"

    # Critical Fix: Upstream includes a *directory* named CMakeCache.txt in the tarball
    # which prevents CMake from generating its cache file. We must remove it.
    rm -rf CMakeCache.txt
}

build() {
    cd "$srcdir/vc4asm-${version}"

    cmake -B build -S . \
        -DCMAKE_INSTALL_PREFIX=/usr \
        -DCMAKE_BUILD_TYPE=Release \
        -DCMAKE_POSITION_INDEPENDENT_CODE=ON

    cmake --build build
}

package() {
    cd "$srcdir/vc4asm-${version}"
    DESTDIR="$pkgdir" cmake --install build
}
