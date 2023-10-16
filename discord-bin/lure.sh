name='discord-bin'
version='0.0.32'
release='1'
desc='All-in-one voice and text chat for gamers'
homepage='https://discord.com/'
maintainer='Elara Musayelyan <elara@elara.ws>'
maintainer_ru='Элара Мусаелян <elara@elara.ws>'
architectures=('amd64')
license=('custom:Discord')
provides=('discord')
conflicts=('discord')

deps=('gconf-service' 'gconf2-common' 'libc++1' 'libxtst6' 'libxss1' 'libstdc++6' 'libnss3' 'libnspr4' 'libnotify4' 'libgconf-2-4' 'libatomic1' 'libasound2' 'libc6' 'libappindicator1')
deps_fedora=('libatomic' 'glibc' 'alsa-lib' 'GConf2' 'libnotify' 'nspr' 'nss' 'libstdc++' 'libX11' 'libXtst' 'libappindicator-gtk3' 'libXScrnSaver')
deps_opensuse=('libatomic1' 'glibc' 'alsa' 'gconf2' 'libnotify' 'mozilla-nspr' 'mozilla-nss' 'libstdc++6' 'libX11' 'libXtst' 'libappindicator' 'libc++1' 'libXScrnSaver')
deps_arch=('libnotify' 'libxss' 'nspr' 'nss' 'gtk3' 'libpulse' 'libappindicator-gtk3' 'xdg-utils')
deps_rosa=('libatomic' 'glibc' 'alsa-lib' 'GConf2' 'libnotify' 'nspr' 'nss' 'libstdc++' 'libX11' 'libXtst' 'libappindicator1' 'libXScrnSaver')

sources=("https://dl.discordapp.net/apps/linux/0.0.32/discord-0.0.32.tar.gz")
checksums=('SKIP')

package() {
	install -Dm644 "${srcdir}/Discord/discord.png" "${pkgdir}/usr/share/pixmaps/discord.png"
	install-desktop "${srcdir}/Discord/discord.desktop"
	cp -a "${srcdir}/Discord" "${pkgdir}/usr/share/discord"
	mkdir -p "${pkgdir}/usr/bin/"
	ln -s "${pkgdir}/usr/share/discord/Discord" "${pkgdir}/usr/bin/discord"
}
