name='logseq-desktop'
version='0.9.3'
release='1'
desc='A privacy-first, open-source platform for knowledge management and collaboration'
homepage='https://logseq.com/'
maintainer="Евгений Храмов <xpamych@yandex.ru>"
architectures=('amd64')
license=('AGPL-3.0 license')
provides=('logseq')
conflicts=('logseq')

sources=("https://github.com/logseq/logseq/releases/download/${version}/logseq-linux-x64-${version}.zip")
checksums=('SKIP')

package() {
	cd "${srcdir}/Logseq-linux-x64"
	install -Dm644 "${scriptdir}/logseq-desktop.desktop" "${pkgdir}/usr/share/applications/logseq-desktop.desktop"
	install -Dm644 "${srcdir}/Logseq-linux-x64/resources/app/icons/logseq.png" "${pkgdir}/usr/share/pixmaps/logseq.png"
	install -d ${pkgdir}/opt/logseq
	cp -r "${srcdir}/Logseq-linux-x64" "${pkgdir}/opt/logseq"
	install -d "${pkgdir}/usr/bin"
	ln -s "/opt/logseq/Logseq-linux-x64/Logseq" "${pkgdir}/usr/bin/logseq"
}
