name="fdbox-git"
version="0.0.0"
release="1"
desc="FreeDOS-like shell and utilities for Linux"
homepage="https://github.com/diegoiast/fdbox"
maintainer="Foad <foad@example.com>"
architectures=("amd64")
license=("GPL-3.0-only")
provides=("fdbox")
conflicts=("fdbox")

# Build Dependencies
# - cmake & git: required for build configuration and CPM downloads
# - python3: detected/used during configuration
# - build-essential: for gcc/make
build_deps=("git" "cmake" "build-essential" "python3")

# Runtime Dependencies
deps=("libc6")

sources=("git+https://github.com/diegoiast/fdbox.git")
checksums=("SKIP")

version() {
	cd "$srcdir/fdbox"
	# Generates a version string like r123.abc1234
	printf "0.0.0.r%s.%s" "$(git rev-list --count HEAD)" "$(git rev-parse --short HEAD)"
}

prepare() {
	# 1. Create build directory
	mkdir -p "$srcdir/fdbox/build"
	cd "$srcdir/fdbox/build"

	# 2. Run CMake
	# We run this in prepare() because it downloads dependencies (CPM)
	# and requires internet access.
	cmake .. -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Release
}

build() {
	cd "$srcdir/fdbox/build"
	# 3. Compile
	make
}

package() {
	cd "$srcdir/fdbox/build"

	# 4. Install
	# Try using the standard make install.
	# The '||' operator ensures that if 'make install' fails (e.g., no target defined),
	# we fall back to installing the binary manually.
	make DESTDIR="$pkgdir" install || install -Dm755 fdbox "$pkgdir/usr/bin/fdbox"
}
