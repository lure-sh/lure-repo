name='lapce-bin'
version='0.2.8'
release='2'
desc='Lightning-fast and Powerful Code Editor'
homepage='https://lapce.dev/'
maintainer='Elara Musayelyan <elara@elara.ws>'
maintainer_ru='Элара Мусаелян <elara@elara.ws>'
architectures=('amd64')
license=('Apache-2.0')
provides=('lapce')
conflicts=('lapce')

deps=('expat' 'fontconfig' 'libfreetype6' 'libgtk-3-0' 'libxcb1' 'libxkbcommon0')
deps_arch=('expat' 'fontconfig' 'freetype2' 'gtk3' 'libxcb' 'libxkbcommon')
deps_fedora=('expat' 'fontconfig' 'freetype' 'gtk3' 'libxcb' 'libxkbcommon')
deps_alpine=('expat' 'fontconfig' 'freetype' 'gtk+3.0' 'libxcb' 'libxkbcommon')
deps_opensuse=('expat' 'fontconfig' 'libfreetype6' 'gtk3' 'libxcb1' 'libxkbcommon0')

sources=(
	"https://github.com/lapce/lapce/releases/download/v${version}/Lapce-linux.tar.gz"
	"https://github.com/lapce/lapce/raw/v${version}/extra/linux/dev.lapce.lapce.desktop"
	"https://github.com/lapce/lapce/raw/v${version}/extra/linux/dev.lapce.lapce.metainfo.xml"
	"https://raw.githubusercontent.com/lapce/lapce/v${version}/extra/images/logo.png"
)

checksums=('SKIP' 'SKIP' 'SKIP' 'SKIP')

package() {
	install-binary "$srcdir/Lapce/lapce"
	install-desktop "$srcdir/dev.lapce.lapce.desktop"
	install -Dm644 logo.png "$pkgdir/usr/share/pixmaps/dev.lapce.lapce.png"
	install -Dm644 dev.lapce.lapce.metainfo.xml "$pkgdir/usr/share/metainfo/dev.lapce.lapce.metainfo.xml"
}
