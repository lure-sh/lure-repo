name='uade'
version='3.05'
release='0'
desc='Unix Amiga Delitracker Emulator'
homepage='https://zakalwe.fi/uade/uade.html'
maintainer='Nil Geisweiller <ngeiswei@gmail.com>'
architectures=('amd64')
license=('GPL-2.0')
provides=('uade')
conflicts=('uade')

build_deps=('make' 'gcc' 'bencodetools' 'libzakalwe')

sources=("https://zakalwe.fi/uade/uade3/uade-${version}.tar.bz2")
checksums=('SKIP')

build() {
	cd "${srcdir}/uade-${version}"
	./configure --prefix="${pkgdir}/usr"
	make -j
}

package() {
	cd "${srcdir}/uade-${version}"
	make install
}
