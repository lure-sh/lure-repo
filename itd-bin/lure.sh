name='itd-bin'
version=1.1.0
release=1
desc='Companion daemon for the InfiniTime firmware on the PineTime smartwatch'
desc_ru='Демон-компаньон для прошивки InfiniTime на смарт-часах PineTime'
maintainer='Elara Musayelyan <elara@elara.ws>'
maintainer_ru='Элара Мусаелян <elara@elara.ws>'
homepage='https://gitea.elara.ws/Elara6331/itd'
architectures=('amd64' 'arm64' 'arm7' 'arm6' '386')
license=('GPL-3.0-or-later')
provides=('itd' 'itctl')
conflicts=('itd' 'itctl')

deps=('dbus' 'bluez' 'pulseaudio-utils')
deps_arch=('dbus' 'bluez' 'libpulse')
deps_opensuse=('dbus-1' 'bluez' 'pulseaudio-utils')

sources_arm64=("https://gitea.elara.ws/Elara6331/itd/releases/download/v1.1.0/itd-1.1.0-linux-aarch64.tar.gz")
checksums_arm64=('d42470c4ef3b3b4690e663e0eb98bf27564364a840c8ace4ffb9fbb4668b0c43')

sources_arm=("https://gitea.elara.ws/Elara6331/itd/releases/download/v1.1.0/itd-1.1.0-linux-arm.tar.gz")
checksums_arm=('5a6b68da41b05e40b53a28a72c1fa296efe3ea28fdea35ab89b0a000fd851080')

sources_386=("https://gitea.elara.ws/Elara6331/itd/releases/download/v1.1.0/itd-1.1.0-linux-i386.tar.gz")
checksums_386=('bfa686c2b7169cb809bbe58bf735d94900aca4d53051232ba2f680f44df45d4b')

sources_amd64=("https://gitea.elara.ws/Elara6331/itd/releases/download/v1.1.0/itd-1.1.0-linux-x86_64.tar.gz")
checksums_amd64=('8b830a82d97ea9f139ce570e8e640822b7ff6e50ef3fdcdb8df4a81aa6a95524')

backup=('/etc/itd.toml')

package() {
	# binaries
	install -Dm755 "./itd" "${pkgdir}/usr/bin/itd"
	install -Dm755 "./itctl" "${pkgdir}/usr/bin/itctl"

	# service
	install -Dm644 "./itd.service" ${pkgdir}/usr/lib/systemd/user/itd.service

	# config
	install -Dm644 "./itd.toml" ${pkgdir}/etc/itd.toml

	# license
	install -Dm644 "./LICENSE" "${pkgdir}/usr/share/licenses/itd/LICENSE"
}
