name="tmsu-git"
version="0.0.0"
release="1"
desc="A tool for tagging your files and accessing them through a virtual filesystem"
homepage="https://tmsu.org/"
maintainer="Ivan Zenin <i.zenin@gmx.com>"
architectures=("amd64")
license=("GPL-3.0-only")
provides=("tmsu")
conflicts=("tmsu")

# Runtime Dependencies (Debian/Ubuntu/Mint)
deps=("fuse3" "libsqlite3-0")

# Build Dependencies
# We need 'gcc' and 'libsqlite3-dev' because go-sqlite3 requires CGO
build_deps=("git" "golang-go" "make" "gcc" "libsqlite3-dev" "libfuse-dev")

# Arch Linux Overrides (kept for reference)
deps_arch=("fuse" "sqlite")
build_deps_arch=("git" "go" "make" "gcc")

sources=("git+https://github.com/oniony/tmsu.git")
checksums=("SKIP")

version() {
	cd "$srcdir/tmsu"
	# Dynamic versioning logic from the PKGBUILD
	(
		set -o pipefail
		git describe --tags 2>/dev/null | sed 's/^v//;s/\([^-]*-g\)/r\1/;s/-/./g' ||
			printf "r%s.%s" "$(git rev-list --count HEAD)" "$(git rev-parse --short HEAD)"
	)
}

prepare() {
	# Set up a local GOPATH inside the build dir
	export GOPATH="$srcdir/go"
	export GO111MODULE=auto
	mkdir -p "$GOPATH"

	echo "Fetching Go dependencies..."
	# We ignore errors here because sometimes go get complains in 'auto' mode
	# but still downloads what is needed.
	go get -u golang.org/x/crypto/blake2b || true
	go get -u github.com/mattn/go-sqlite3 || true
	go get -u github.com/hanwen/go-fuse/fuse || true
}

build() {
	export GOPATH="$srcdir/go"
	export GO111MODULE=auto

	cd "$srcdir/tmsu"
	make
}

package() {
	cd "$srcdir/tmsu"

	# Create installation directories
	mkdir -p "${pkgdir}/usr/bin" \
		"${pkgdir}/usr/share/man/man1" \
		"${pkgdir}/usr/share/zsh/site-functions" \
		"${pkgdir}/usr/share/bash-completion/completions"

	# Run the make install
	make INSTALL_DIR="${pkgdir}/usr/bin" \
		MOUNT_INSTALL_DIR="${pkgdir}/usr/bin" \
		MAN_INSTALL_DIR="${pkgdir}/usr/share/man/man1" \
		BASH_COMP_INSTALL_DIR="${pkgdir}/usr/share/bash-completion/completions" \
		ZSH_COMP_INSTALL_DIR="${pkgdir}/usr/share/zsh/site-functions" \
		install
}
