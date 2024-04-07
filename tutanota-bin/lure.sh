name='tutanota-bin'
version="220.240403.0"
release=1
desc='Official Tutanota email client'
maintainer='Elara Musayelyan <elara@elara.ws>'
maintainer_ru='Элара Мусаелян <elara@elara.ws>'
homepage='https://tuta.com/'
architectures=('amd64')
license=('GPL-3.0-or-later')

provides=('tutanota' 'tutanota-desktop')
conflicts=('tutanota' 'tutanota-desktop')

deps=('libasound2' 'libgtk-3-0' 'libsecret-1-0' 'libnss3')
deps_arch=('alsa-lib' 'gtk3' 'libsecret' 'nss') 
deps_opensuse=('libasound2' 'libgtk-3-0' 'libsecret-1-0')

sources=("https://github.com/tutao/tutanota/releases/download/tutanota-desktop-release-${version}/tutanota-desktop-${version}-unpacked-linux.tar.gz" "local:///tutanota.desktop")
checksums=('ccff2093bf2bfc55910c48c3e7fc89b15e28f316d5ad39017508ab506afa0409' 'SKIP')

package() {
	mkdir -p "$pkgdir/opt"
	mkdir -p "$pkgdir/usr/bin"
	cp -a "$srcdir/linux-unpacked" "$pkgdir/opt/tutanota"
	ln -s "$pkgdir/opt/tutanota/tutanota-desktop" "$pkgdir/usr/bin/tutanota-desktop"

	install-icon "$srcdir/linux-unpacked/resources/icons/icon/512.png" tutanota-desktop.png
	install-desktop "$srcdir/tutanota.desktop"
}
