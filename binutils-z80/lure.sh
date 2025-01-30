name='binutils-z80'
version='2.42'
release='2'
desc='Cross-build binary utilities for z80'
homepage='https://www.gnu.org/software/binutils/'
maintainer='Atirut Wattanamongkol <atirut.wattanamongkol@gmail.com>'
architectures=('amd64')
license=('GPL-2.0-only')

deps=('gmp' 'mpfr')
build_deps_fedora=('gmp-devel' 'mpfr-devel' 'texinfo' 'make' 'gcc' 'perl' 'bison')

sources=('https://ftp.gnu.org/gnu/binutils/binutils-2.42.tar.xz')
checksums=('SKIP')

prepare() {
	cd "$srcdir/binutils-2.42"
	# Turn off dev mode (very strict compiler flags)
	sed -i '/^development=/s/true/false/' bfd/development.sh
}

build() {
	cd "$srcdir/binutils-2.42"
	./configure --target=z80-elf --prefix=/usr
	make -j$(NCPU)
}

package() {
	cd "$srcdir/binutils-2.42"
	make DESTDIR="$pkgdir" install

	# Clean up conflicting files
	rm -r "$pkgdir/usr/lib/"
	rm -r "$pkgdir/usr/lib64/"
	rm -r "$pkgdir/usr/share/info/"
	rm -r "$pkgdir/usr/share/locale/"
}
