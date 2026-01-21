name="clinfo-git"
version="0.0.0"
release="1"
desc="Print all known information about all available OpenCL platforms and devices in the system"
homepage="https://github.com/Oblomov/clinfo"
maintainer="Foad Sojoodi Farimani <f.s.farimani@gmail.com>"
architectures=("arm64" "arm" "amd64")
license=("custom:Public Domain")
provides=("clinfo")

# Runtime dependencies
deps=("ocl-icd-libopencl1")

# Build dependencies
build_deps=(
    "git"
    "build-essential"
    "opencl-headers"
    "ocl-icd-opencl-dev"
)

sources=("git+https://github.com/Oblomov/clinfo.git")
checksums=("SKIP")

version() {
    cd "$srcdir/clinfo"
    # Get version from git tags, make it Debian-compliant
    local ver=$(git describe --long --tags 2>/dev/null | sed 's/-/.r/;s/-/./')
    if [ -n "$ver" ]; then
        echo "$ver"
    else
        printf "0.0.0.r%s.%s" "$(git rev-list --count HEAD)" "$(git rev-parse --short HEAD)"
    fi
}

build() {
    cd "$srcdir/clinfo"
    make
}

package() {
    cd "$srcdir/clinfo"
    make PREFIX="$pkgdir/usr" MANDIR="$pkgdir/usr/share/man" install
    install -Dm644 LICENSE "$pkgdir/usr/share/licenses/$name/LICENSE"
}
