name='scdoc-git'
version='148.afeda24'
release='1'
desc='scdoc is a simple man page generator for POSIX systems written in C99.'
homepage='https://git.sr.ht/~sircmpwn/scdoc'
maintainer="Elara M <elara@elara.ws>"
maintainer_ru='Элара Мусаелян <elara@elara.ws>'
architectures=('amd64' 'arm64' 'arm' '386' 'riscv64')
license=('MIT')
provides=('scdoc')
conflicts=('scdoc')

build_deps=('gcc')

sources=('git+https://git.sr.ht/~sircmpwn/scdoc')
checksums=('SKIP')

version() {
	cd "$srcdir/scdoc"
	git-version
}

build() {
	cd "$srcdir/scdoc"
	make PREFIX='/usr' DESTDIR="$pkgdir"
}

package() {
	cd "$srcdir/scdoc"
	make PREFIX='/usr' DESTDIR="$pkgdir" install
}
