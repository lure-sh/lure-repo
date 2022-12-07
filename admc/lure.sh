name='admc'
version='0.11.0'
release='2'
desc='user-friendly инструмент для Linux для работы с доменом Active Directory и групповыми политиками.'
homepage='https://github.com/altlinux/admc.git'
architectures=('amd64')
license=('GPL-3.0-or-later')
provides=('admc')
conflicts=('admc')

build_deps=('cmake' 'gcc' 'gcc-c++' 'qt5-qtbase-devel' 'qt5-linguist' 'openldap-devel' 'samba-devel' 'libsmbclient-devel' 'krb5-devel' 'libuuid-devel')
build_deps_debian=('cmake' 'debhelper' 'qtbase5-dev' 'qttools5-dev' 'libldap2-dev' 'samba-dev' 'libsmbclient-dev' 'libkrb5-dev' 'uuid-dev' 'libsasl2-dev')

sources_amd64=("git+https://github.com/altlinux/${name}.git")
checksums_amd64=('SKIP')

prepare() {
	cd "${srcdir}/${name}"
	mkdir build
}

build() {
	cd "${srcdir}/${name}/build"
	cmake ..
	make -j12
}

package() {
	install -Dm755 "${srcdir}/${name}/build/admc" "${pkgdir}/usr/bin/admc"
	install -Dm644 "${srcdir}/${name}/build/libadldap.so" "${pkgdir}/usr/lib/libadldap.so"
	install -Dm644 "${srcdir}/${name}/share/admc.desktop" "${pkgdir}/usr/share/applications/admc.desktop"
	install -Dm644 "${srcdir}/${name}/share/admc.svg" "${pkgdir}/usr/share/icons/hicolor/scalable/apps/admc.svg"
}
