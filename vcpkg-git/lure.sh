name="vcpkg-git"
version="0.0.0"
release="2"
desc="C++ library manager for Windows, Linux, and MacOS"
homepage="https://github.com/microsoft/vcpkg"
maintainer="Your Name <email@example.com>"
architectures=("amd64" "arm64")
license=("MIT")
provides=("vcpkg")
conflicts=("vcpkg")

# Build Dependencies
build_deps=("git" "cmake" "ninja-build" "curl" "zip" "unzip" "build-essential" "ca-certificates")

# Runtime Dependencies
deps=("curl" "zip" "unzip" "git")

sources=("git+https://github.com/microsoft/vcpkg.git")
checksums=("SKIP")

version() {
	cd "$srcdir/vcpkg"
	if git describe --long --tags >/dev/null 2>&1; then
		git describe --long --tags | sed 's/^v//;s/\([^-]*-g\)/r\1/;s/-/./g'
	else
		printf "r%s.%s" "$(git rev-list --count HEAD)" "$(git describe --always)"
	fi
}

prepare() {
	cat <<EOF >"$srcdir/vcpkg_wrapper.sh"
#!/bin/sh
export VCPKG_ROOT="/opt/vcpkg"
[ -z "\$VCPKG_DOWNLOADS" ] && export VCPKG_DOWNLOADS="/var/cache/vcpkg"
exec /opt/vcpkg/vcpkg "\$@"
EOF
}

build() {
	cd "$srcdir/vcpkg"
	# Force system binaries via environment variable since the flag was ignored
	export VCPKG_USE_SYSTEM_BINARIES=1

	# Bootstrap the binary
	./bootstrap-vcpkg.sh -disableMetrics
}

package() {
	# Define paths without 'local' keyword to avoid shell issues
	VCPKG_ROOT="/opt/vcpkg"
	VCPKG_DOWNLOADS="/var/cache/vcpkg"

	# 1. Install Wrapper Script
	install -Dm755 "$srcdir/vcpkg_wrapper.sh" "$pkgdir/usr/bin/vcpkg"

	# 2. Install Main Binary
	# We look for the binary in the source root
	install -Dm755 "$srcdir/vcpkg/vcpkg" "$pkgdir/$VCPKG_ROOT/vcpkg"

	# 3. Copy required support directories
	mkdir -p "$pkgdir/$VCPKG_ROOT"
	cp -r "$srcdir/vcpkg/ports" "$pkgdir/$VCPKG_ROOT/"
	cp -r "$srcdir/vcpkg/scripts" "$pkgdir/$VCPKG_ROOT/"
	cp -r "$srcdir/vcpkg/triplets" "$pkgdir/$VCPKG_ROOT/"
	cp -r "$srcdir/vcpkg/versions" "$pkgdir/$VCPKG_ROOT/" 2>/dev/null || true # Copy versions if it exists

	# Create the marker file
	touch "$pkgdir/$VCPKG_ROOT/.vcpkg-root"

	# 4. Create Cache Directory with sticky bit
	install -dm1777 "$pkgdir/$VCPKG_DOWNLOADS"

	# 5. Install License
	install -Dm644 "$srcdir/vcpkg/LICENSE.txt" "$pkgdir/usr/share/licenses/$name/LICENSE"
}
