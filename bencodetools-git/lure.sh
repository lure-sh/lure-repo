name='bencodetools-git'
version='1.0.1'
release='0'
desc='bencode-tools is a collection of tools for manipulating bencoded data'
homepage='http://zakalwe.fi/~shd/foss/bencode-tools/'
maintainer="Nil Geisweiller <ngeiswei@gmail.com>"
architectures=('amd64')
license=('BSD-3-Clause')
provides=('bencodetools')
conflicts=('bencodetools')
build_deps=('make' 'gcc')
sources=("git+https://gitlab.com/heikkiorsila/bencodetools.git")
checksums=('SKIP')

version() {
	cd "${srcdir}/bencodetools"
	git-version
}

build() {
	cd "${srcdir}/bencodetools"
	./configure --prefix="${pkgdir}/usr"
	make -j
}

package() {
	cd "${srcdir}/bencodetools"
	make install-c
}
