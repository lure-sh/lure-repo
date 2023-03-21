name='steamcmd'
version='1'
release='1'
desc='Steam Command Line Tools'
homepage='http://developer.valvesoftware.com/wiki/SteamCMD'
maintainer="Евгений Храмов <xpamych@yandex.ru>"
architectures=('amd64' '386')
license=('custom')
provides=('steamcmd, steamerrorreporter')
conflicts=('steamcmd, steamerrorreporter')
deps_amd64=('libgcc(x86-32)')
deps_amd64_arch=('lib32-gcc-libs')
deps_amd64_rosa=('lib64gcc1')


    sources=("https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz")
checksums=('SKIP')

prepare() {
	cd "${srcdir}"
}

package() {
	install -Dm755 "${scriptdir}/steamcmd" "${pkgdir}/usr/bin/steamcmd"
	install -Dm755 "${srcdir}/steamcmd.sh" "${pkgdir}/usr/share/steamcmd/steamcmd.sh"
    install -Dm755 "${srcdir}/linux32/crashhandler.so" "${pkgdir}/usr/share/steamcmd/linux32/crashhandler.so"
    install -Dm755 "${srcdir}/linux32/libstdc++.so.6" "${pkgdir}/usr/share/steamcmd/linux32/libstdc++.so.6"
    install -Dm755 "${srcdir}/linux32/steamcmd" "${pkgdir}/usr/share/steamcmd/linux32/steamcmd"
    install -Dm755 "${srcdir}/linux32/steamerrorreporter" "${pkgdir}/usr/share/steamcmd/linux32/steamerrorreporter"
}
