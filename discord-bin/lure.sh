name='discord-bin'
version='0.0.22'
release='1'
desc='Discord (popular voice + video app) using the system provided electron for increased security and performance'
homepage='homepage=''https://discord.com/'
maintainer="Евгений Храмов <xpamych@yandex.ru>"
architectures=('amd64')
license=('custom')
provides=('discord')
conflicts=('discord')

deps=('libXScrnSaver' 'xdg-utils')

sources=("https://dl.discordapp.net/apps/linux/${version}/${provides}-${version}.tar.gz")
checksums=('SKIP')

prepare() {
	cd ${srcdir}
	sed -i "s|Exec=/usr/share/discord/Discord|Exec=/opt/discord/${provides}|" ./Discord/${provides}.desktop
}

package() {
	install -Dm755 "${srcdir}/Discord/Discord" "${pkgdir}/opt/discord/discord"
	install -Dm644 "${srcdir}/Discord/discord.png" "${pkgdir}/usr/share/pixmaps/${provides}.png"
	install -Dm644 "${srcdir}/Discord/${provides}.desktop" "${pkgdir}/usr/share/applications/${provides}.desktop"
	cd "${srcdir}/Discord"
	find . -type d -exec install -d {,"${pkgdir}/opt/discord/"}{} \;
	find . -type f -exec install -D {,"${pkgdir}/opt/discord/"}{} \;
	install -dm755 "${pkgdir}/usr/bin/"
	ln -s "${pkgdir}/opt/${provides}/${provides}" "${pkgdir}/usr/bin/${provides}"
}
