name='glue-git'
version=1.0
release=1
desc='Alignable paste alternative commandline utility.'
architectures=('all')
homepage='https://github.com/Elagoht/Glue'
license=('GPL-3.0-or-later')
maintainer='Furkan Baytekin (Elagoht) <furkanbaytekin@gmail.com>'
provides=('glue')
deps=('python3')
sources=('git+https://github.com/Elagoht/Glue')
checksums=('SKIP')
version() {
	cd "$srcdir/Glue"
	git-version
}
package() {
	install -d "$pkgdir/usr/bin/"
	install -Dm755 "Glue/glue" -t "$pkgdir/usr/bin"
}
