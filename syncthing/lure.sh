name='syncthing'
version='1.22.1'
release='1'
desc='Syncthing is a continuous file synchronization program. It synchronizes files between two or more computers.'
homepage='https://syncthing.net/'
architectures=('amd64')
license=('MPL-2.0')
provides=('syncthing')
conflicts=('syncthing')
deps_amd64=('glibc' 'strelaysrv')
build_deps=('git' 'go')
sources_amd64=("https://github.com/${name}/${name}/releases/download/v${version}/${name}-linux-amd64-v${version}.tar.gz")
checksums_amd64=('f91066b8588c02b5ff77aa801cc4e0319f3467325bdd75326aebccffb6495698')

prepare() {
	cd "${srcdir}"
}

package() {
	install -Dm755 ./${name}-linux-amd64-v${version}/syncthing "${pkgdir}/usr/bin/syncthing"
	#install -Dm644 man/strelaysrv.1 "${pkgdir}/usr/share/man/man1/${name}.1"
	install -Dm644 ./${name}-linux-amd64-v${version}/README.txt "${pkgdir}/usr/share/doc/syncthing/README.md"
	install -Dm644 "./${name}-linux-amd64-v${version}/etc/linux-systemd/system/syncthing-resume.service" "${pkgdir}/usr/lib/systemd/system/syncthing-resume.service"
	install -Dm644 "./${name}-linux-amd64-v${version}/etc/linux-systemd/system/syncthing@.service" "${pkgdir}/usr/lib/systemd/system/syncthing@.service"
	install -Dm644 "./${name}-linux-amd64-v${version}/etc/linux-systemd/user/syncthing.service" "${pkgdir}/usr/lib/systemd/user/syncthing.service"
}
