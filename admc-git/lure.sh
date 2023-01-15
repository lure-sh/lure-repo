name='admc-git'
version='3580.5a24f61'
release='1'
desc='user-friendly инструмент для Linux для работы с доменом Active Directory и групповыми политиками.'
homepage='https://github.com/altlinux/admc.git'
maintainer="Евгений Храмов <xpamych@yandex.ru>"
architectures=('amd64')
license=('GPL-3.0-or-later')
provides=('admc')
conflicts=('admc')

build_deps=('cmake' 'gcc' 'gcc-c++' 'qt5-qtbase-devel' 'qt5-linguist' 'openldap-devel' 'samba-devel' 'libsmbclient-devel' 'krb5-devel' 'libuuid-devel')
build_deps_debian=('cmake' 'debhelper' 'qtbase5-dev' 'qttools5-dev' 'libldap2-dev' 'samba-dev' 'libsmbclient-dev' 'libkrb5-dev' 'uuid-dev' 'libsasl2-dev')

sources=("git+https://github.com/altlinux/admc.git")
checksums=('SKIP')

version() {
	cd "$srcdir/admc"
	git-version
}

prepare() {
	cd "${srcdir}/admc"
	mkdir build
}

build() {
	cd "${srcdir}/admc/build"
	cmake ..
	make -j12
}

package() {
	install -Dm755 "${srcdir}/admc/build/admc" "${pkgdir}/usr/bin/admc"
	install -Dm644 "${srcdir}/admc/build/libadldap.so" "${pkgdir}/usr/lib/libadldap.so"
	install -Dm644 "${srcdir}/admc/share/admc.desktop" "${pkgdir}/usr/share/applications/admc.desktop"
	install -Dm644 "${srcdir}/admc/share/admc.svg" "${pkgdir}/usr/share/icons/hicolor/scalable/apps/admc.svg"
}
