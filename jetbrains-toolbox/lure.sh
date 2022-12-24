name='jetbrains-toolbox'
version='1.27.2.13801'
release='1'
desc='Manage all your JetBrains Projects and Tools'
homepage='https://www.jetbrains.com/toolbox/'
architectures=('amd64')
license=('jetbrains')
provides=('jetbrains-toolbox')
conflicts=('jetbrains-toolbox')

deps=('java-11-openjdk' 'fuse' 'glib2' 'libxslt' 'libXScrnSaver' 'xcb-util-keysyms' 'xdg-utils' 'nss')

sources_amd64=("https://download.jetbrains.com/toolbox/${name}-${version}.tar.gz")
checksums_amd64=('SKIP')

package() {
	install -dm755 "${pkgdir}/usr/bin/"
	install -Dm644 "${scriptdir}/${name}.desktop" "${pkgdir}/usr/share/applications/${name}.desktop"
	install -Dm644 "${scriptdir}/icon.svg" "${pkgdir}/usr/share/pixmaps/${name}.svg"
	install -Dm755 "${srcdir}/${name}-${version}/${name}" "${pkgdir}/opt/${name}/${name}"
	install -Dm644 "${srcdir}/LICENSE" "${pkgdir}/usr/share/licenses/${name}/LICENSE.txt"

	ln -s "/opt/${name}/${name}" "${pkgdir}/usr/bin/${name}"
}
