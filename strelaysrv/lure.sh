name='strelaysrv'
version='1.22.1'
release='1'
desc='This is the relay server for the syncthing project.'
homepage='https://syncthing.net/'
architectures=('amd64')
license=('MPL-2.0')
provides=('syncthing-relaysrv')
conflicts=('syncthing-relaysrv')
deps_amd64=('glibc')
build_deps=('git' 'go')
sources=("https://github.com/syncthing/relaysrv/releases/download/v${version}/${name}-linux-amd64-v${version}.tar.gz"
	"https://raw.githubusercontent.com/archlinux/svntogit-community/packages/syncthing/trunk/syncthing-relaysrv.service"
	"https://raw.githubusercontent.com/archlinux/svntogit-community/packages/syncthing/trunk/syncthing-relaysrv.tmpfiles"
	"https://raw.githubusercontent.com/archlinux/svntogit-community/packages/syncthing/trunk/syncthing-relaysrv.sysusers")
checksums=('04028d3eb50bc6f007da1b65c2b37f9b8b3109efe4c8973f285893872081959b'
	'SKIP'
	'SKIP'
	'SKIP')

prepare() {
	cd "${srcdir}"
}

package() {
	install -Dm755 ./${name}-linux-amd64-v${version}/strelaysrv "${pkgdir}/usr/bin/syncthing-relaysrv"
	install -Dm644 "${srcdir}/syncthing-relaysrv.service" "${pkgdir}/usr/lib/systemd/system/syncthing-relaysrv.service"
	install -Dm644 "${srcdir}/syncthing-relaysrv.tmpfiles" "${pkgdir}/usr/lib/tmpfiles.d/syncthing-relaysrv.conf"
	install -Dm644 "${srcdir}/syncthing-relaysrv.sysusers" "${pkgdir}/usr/lib/sysusers.d/syncthing-relaysrv.conf"
}
