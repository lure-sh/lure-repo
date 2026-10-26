name="fdbox-git"
version="0"
release="1"
desc="FreeDOS-like shell and utilities for Linux"
homepage="https://github.com/diegoiast/fdbox"
maintainer="Foad <f.s.farimani@gmail.com>"
architectures=("amd64")
license=("GPL-3.0-only")
provides=("fdbox")
conflicts=("fdbox")

# git is needed at configure time: CPM clones Format.cmake
build_deps=("git" "cmake" "build-essential")

deps=("libc6")

sources=("git+https://github.com/diegoiast/fdbox.git")
checksums=("SKIP")

version() {
	cd "$srcdir/fdbox"
	git-version
}

prepare() {
	# Configure here because CPM downloads dependencies
	cmake -S "$srcdir/fdbox" -B "$srcdir/fdbox/build" -DCMAKE_BUILD_TYPE=Release
}

build() {
	cmake --build "$srcdir/fdbox/build" --target fdbox
}

package() {
	# Upstream defines no install() rules, so install the binary directly
	install-binary "$srcdir/fdbox/build/fdbox"
}
