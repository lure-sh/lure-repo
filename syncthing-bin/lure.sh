name='syncthing-bin'
version='1.23.0'
release='1'
desc='Syncthing is a continuous file synchronization program. It synchronizes files between two or more computers.'
homepage='https://syncthing.net/'
maintainer="Евгений Храмов <xpamych@yandex.ru>"
architectures=('amd64')
license=('MPL-2.0')
provides=('syncthing')
conflicts=('syncthing')
deps=('glibc' 'syncthing-relaysrv')
deps_debian=('libc6')
build_deps=('git' 'go')

sources_amd64=("https://github.com/${provides}/${provides}/releases/download/v${version}/${provides}-linux-amd64-v${version}.tar.gz")
checksums_amd64=('SKIP')

prepare() {
	cd "${srcdir}"
}

package() {
	install -Dm755 ./${provides}-linux-amd64-v${version}/syncthing "${pkgdir}/usr/bin/syncthing"
	#install -Dm644 man/strelaysrv.1 "${pkgdir}/usr/share/man/man1/${provides}.1"
	install -Dm644 ./${provides}-linux-amd64-v${version}/README.txt "${pkgdir}/usr/share/doc/syncthing/README.md"
	install -Dm644 "./${provides}-linux-amd64-v${version}/etc/linux-systemd/system/syncthing-resume.service" "${pkgdir}/usr/lib/systemd/system/syncthing-resume.service"
	install -Dm644 "./${provides}-linux-amd64-v${version}/etc/linux-systemd/system/syncthing@.service" "${pkgdir}/usr/lib/systemd/system/syncthing@.service"
	install -Dm644 "./${provides}-linux-amd64-v${version}/etc/linux-systemd/user/syncthing.service" "${pkgdir}/usr/lib/systemd/user/syncthing.service"
}
