name='discord-bin'
version='0.0.27'
release='1'
desc='Discord (popular voice + video app) using the system provided electron for increased security and performance'
homepage='https://discord.com/'
maintainer="Евгений Храмов <xpamych@yandex.ru>"
architectures=('amd64')
license=('custom')
provides=('discord')
conflicts=('discord')

deps=('libXScrnSaver' 'xdg-utils')

sources=("https://dl.discordapp.net/apps/linux/${version}/discord-${version}.tar.gz")
checksums=('SKIP')

package() {
	mkdir -p "${pkgdir}/usr/share/"
	install -Dm644 "${srcdir}/Discord/discord.png" "${pkgdir}/usr/share/pixmaps/discord.png"
	install -Dm644 "${srcdir}/Discord/discord.desktop" "${pkgdir}/usr/share/applications/discord.desktop"
	cp -a "${srcdir}/Discord" "${pkgdir}/usr/share/discord"
	mkdir -p "${pkgdir}/usr/bin/"
	ln -s "${pkgdir}/usr/share/discord/Discord" "${pkgdir}/usr/bin/discord"
}
