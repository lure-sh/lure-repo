name='itd-bin'
version=0.0.9
release=1
desc='Companion daemon for the InfiniTime firmware on the PineTime smartwatch'
homepage='https://gitea.arsenm.dev/Arsen6331/itd'
architectures=('amd64' 'aarch64' 'arm7' 'arm6' '386')
license=('GPL-3.0-or-later')
provides=('itd' 'itctl')
conflicts=('itd' 'itctl')

deps=('dbus' 'bluez' 'pulseaudio-utils')
deps_arch=('dbus' 'bluez' 'libpulse')
deps_opensuse=('dbus-1' 'bluez' 'pulseaudio-utils')

sources_arm64=("https://gitea.arsenm.dev/Arsen6331/itd/releases/download/v0.0.9/itd_0.0.9_linux_aarch64.tar.gz")
checksums_arm64=('262108ade80aa940eec254b1f4c66064851faae9253af2b9d4a77c070aed2c9d')

sources_arm=("https://gitea.arsenm.dev/Arsen6331/itd/releases/download/v0.0.9/itd_0.0.9_linux_armv6.tar.gz")
checksums_arm=('2d922e2d32135dd64187413407c1f3f952ac8c5bf5c80f45863fb9f644263249')

sources_386=("https://gitea.arsenm.dev/Arsen6331/itd/releases/download/v0.0.9/itd_0.0.9_linux_i386.tar.gz")
checksums_386=('29da3d3207777c6693835ea1a18da41034345286f7c044e3bbcb9b93993eef4e')

sources_amd64=("https://gitea.arsenm.dev/Arsen6331/itd/releases/download/v0.0.9/itd_0.0.9_linux_x86_64.tar.gz")
checksums_amd64=('93d3d7c1c20f00fa3c3c1a5df257a72c48ec351a03f00ca6294afb0db48abeb9')

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
