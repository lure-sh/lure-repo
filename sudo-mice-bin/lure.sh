name='sudo-mice-bin'
version=1.0
release=1
desc='A pixel graphics CLI GUI two players game.'
architectures=('amd64')
homepage='https://github.com/Elagoht/SudoMice'
license=('Unlicense')
maintainer='Furkan Baytekin (Elagoht) <furkanbaytekin@gmail.com>'
provides=('sudo-mice')
sources_amd64=("https://github.com/Elagoht/SudoMice/releases/download/v$version/SudoMice.tar.gz")
checksums_amd64=('cc04350147e691342d8d312cb35ffc2c76b78fc53a0e2e70af1703f991c18ecd')
deps_arch=('glu')
deps_opensuse=('mesa-libGLU')
deps_debian=('libglu1-mesa')
package() {
	rm -v install.sh
	install -d "$pkgdir/usr/share/applications"
	install -Dm644 "SudoMice.desktop" -t "$pkgdir/usr/share/applications"
	install -d "$pkgdir/usr/share/sudomice"
	mv -v "assets" "$pkgdir/usr/share/sudomice/"
	install -Dm755 "SudoMice" "$pkgdir/usr/share/sudomice"
	install -d "$pkgdir/usr/bin"
	ln -sv "/usr/share/sudomice/SudoMice" "$pkgdir/usr/bin/sudo-mice"
}
