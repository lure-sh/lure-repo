name='admc'
version='0.13.0-alt1'
release='1'
desc='User-friendly Linux tool for working with Active Directory domains and group policies.'
desc_ru='user-friendly инструмент для Linux для работы с доменом Active Directory и групповыми политиками.'
homepage='https://github.com/altlinux/admc.git'
maintainer="Евгений Храмов <xpamych@yandex.ru>"
architectures=('amd64')
license=('GPL-3.0-or-later')
provides=('admc')
conflicts=('admc' 'admc-git')

build_deps=('cmake' 'gcc' 'gcc-c++' 'qt5-qtbase-devel' 'qt5-linguist' 'openldap-devel' 'samba-devel' 'libsmbclient-devel' 'krb5-devel' 'libuuid-devel')
build_deps_debian=('cmake' 'debhelper' 'qtbase5-dev' 'qttools5-dev' 'libldap2-dev' 'samba-dev' 'libsmbclient-dev' 'libkrb5-dev' 'uuid-dev' 'libsasl2-dev')

sources=("https://github.com/altlinux/admc/archive/refs/tags/${version}.tar.gz")
checksums=('SKIP')

prepare() {
	cd "${srcdir}/admc-${version}"
	mkdir build
}

build() {
	cd "${srcdir}/admc-${version}/build"
	cmake ..
	make -j12
}

package() {
	install -Dm755 "${srcdir}/admc-${version}/build/admc" "${pkgdir}/usr/bin/admc"
	install -Dm644 "${srcdir}/admc-${version}/build/libadldap.so" "${pkgdir}/usr/lib/libadldap.so"
	install -Dm644 "${srcdir}/admc-${version}/share/admc.desktop" "${pkgdir}/usr/share/applications/admc.desktop"
	install -Dm644 "${srcdir}/admc-${version}/share/admc.svg" "${pkgdir}/usr/share/icons/hicolor/scalable/apps/admc.svg"
}
