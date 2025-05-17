name='libzakalwe-git'
version='1.0.0'
release='0'
desc='Library for functions shared across zakalwe projects'
homepage='https://gitlab.com/hors/libzakalwe'
maintainer="Nil Geisweiller <ngeiswei@gmail.com>"
architectures=('amd64')
license=('BSD-2-Clause')
provides=('libzakalwe')
conflicts=('libzakalwe')
build_deps=('make' 'gcc')
sources=("git+https://gitlab.com/hors/libzakalwe.git")
checksums=('SKIP')

version() {
	cd "${srcdir}/libzakalwe"
	git-version
}

build() {
	cd "${srcdir}/libzakalwe"
	./configure
	make -j
}

package() {
	cd "${srcdir}/libzakalwe"
	mkdir -p "${pkgdir}/usr/lib"
	make PREFIX="${pkgdir}/usr" install
}
