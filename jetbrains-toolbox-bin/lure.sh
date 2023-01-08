name='jetbrains-toolbox'
version='1.27.2.13801'
release='1'
desc='Manage all your JetBrains Projects and Tools'
homepage='https://www.jetbrains.com/toolbox/'
maintainer="Евгений Храмов <xpamych@yandex.ru>"
architectures=('amd64')
license=('custom:Jetbrains')
provides=('jetbrains-toolbox')
conflicts=('jetbrains-toolbox')

deps=('java-11-openjdk' 'fuse' 'glib2' 'libxslt' 'libXScrnSaver' 'xcb-util-keysyms' 'xdg-utils' 'nss')

sources=("https://download.jetbrains.com/toolbox/${provides}-${version}.tar.gz")
checksums=('SKIP')

package() {
	install -dm755 "${pkgdir}/usr/bin/"
	install -Dm644 "${scriptdir}/${provides}.desktop" "${pkgdir}/usr/share/applications/${provides}.desktop"
	install -Dm644 "${scriptdir}/icon.svg" "${pkgdir}/usr/share/pixmaps/${provides}.svg"
	install -Dm755 "${srcdir}/${provides}-${version}/${provides}" "${pkgdir}/opt/${provides}/${provides}"
	install -Dm644 "${srcdir}/LICENSE" "${pkgdir}/usr/share/licenses/${provides}/LICENSE.txt"

	ln -s "/opt/${provides}/${provides}" "${pkgdir}/usr/bin/${provides}"
}
