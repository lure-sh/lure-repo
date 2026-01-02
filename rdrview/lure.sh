name="rdrview"
version="0.1.5"
release="1"
desc="Firefox Reader View as a command line tool"
homepage="https://github.com/eafer/rdrview"
maintainer="Nebulosa <nebulosa2007-at-yandex-dot-ru>"
architectures=("amd64")
license=("Apache-2.0")

# Runtime dependencies (Ubuntu/Mint names)
deps=("curl" "libseccomp2" "libxml2")

# Build dependencies (Headers needed for compilation)
build_deps=("git" "libseccomp-dev" "libxml2-dev" "libcurl4-openssl-dev" "build-essential")

sources=("https://github.com/eafer/rdrview/archive/v${version}/${name}-${version}.tar.gz")
checksums=("sha512:061d0241e6b24a0ad86ae30f5ca0ffd697b6f10ba5d66eb7ca83135095cd0e5efb8501166f55622465d861cd027d64a9568d1f567ba727dd35f5dcec60eaadf1")

prepare() {
	cd "${name}-${version}"
	# Replaces the git command in Makefile with the actual version to prevent errors
	sed -i "s/GIT_COMMIT = \$(shell git rev-parse --short HEAD)/GIT_COMMIT = ${version}/" Makefile
}

build() {
	cd "${name}-${version}"
	make
}

package() {
	cd "${name}-${version}"
	make PREFIX="${pkgdir}/usr" install
}
