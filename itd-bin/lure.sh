name='itd-bin'
version=1.0.0
release=1
desc='Companion daemon for the InfiniTime firmware on the PineTime smartwatch'
homepage='https://gitea.arsenm.dev/Arsen6331/itd'
architectures=('amd64' 'arm64' 'arm7' 'arm6' '386')
license=('GPL-3.0-or-later')
provides=('itd' 'itctl')
conflicts=('itd' 'itctl')

deps=('dbus' 'bluez' 'pulseaudio-utils')
deps_arch=('dbus' 'bluez' 'libpulse')
deps_opensuse=('dbus-1' 'bluez' 'pulseaudio-utils')

sources_arm64=("https://gitea.arsenm.dev/Arsen6331/itd/releases/download/v1.0.0/itd_1.0.0_linux_aarch64.tar.gz")
checksums_arm64=('8f0bb0b83f0f6ec34505237bda8a03be5a9efd792ecb012ae8657ceecd63ab44')

sources_arm=("https://gitea.arsenm.dev/Arsen6331/itd/releases/download/v1.0.0/itd_1.0.0_linux_armv6.tar.gz")
checksums_arm=('0e7b62312ee360678dcc125e2f6489f559e5d7af2b605d029639c6be668aa437')

sources_386=("https://gitea.arsenm.dev/Arsen6331/itd/releases/download/v1.0.0/itd_1.0.0_linux_i386.tar.gz")
checksums_386=('5ba134ba993c470a0d5a5d5c4a67c715aa308131008e1eab3e155b788c3806a3')

sources_amd64=("https://gitea.arsenm.dev/Arsen6331/itd/releases/download/v1.0.0/itd_1.0.0_linux_x86_64.tar.gz")
checksums_amd64=('7ae13460e9b911827355c23ca77a0c59a7099c9988e61366b84a797af682405a')

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
