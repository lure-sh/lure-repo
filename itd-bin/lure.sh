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
checksums_arm64=('a10aaa7d72129b0767c9881158c73d41a3e547344ae0cf5c44d8d51570847af5')

sources_arm=("https://gitea.arsenm.dev/Arsen6331/itd/releases/download/v0.0.9/itd_0.0.9_linux_armv6.tar.gz")
checksums_arm=('2c3d5642ad1ecf7ce717442a3529f00651e6d5bbec1cef15d2f13dd201233d22')

sources_386=("https://gitea.arsenm.dev/Arsen6331/itd/releases/download/v0.0.9/itd_0.0.9_linux_i386.tar.gz")
checksums_386=('858b14a51bb24e7ad41958cccfe8a9aa66b167a6aaee86d5f34bee8f79d8feb2')

sources_amd64=("https://gitea.arsenm.dev/Arsen6331/itd/releases/download/v0.0.9/itd_0.0.9_linux_x86_64.tar.gz")
checksums_amd64=('f09c928fa3b4c810da016d984fde4f9ea2504faed17c7e1633d21d65a07d5f22')

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
