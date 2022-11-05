name='admc'
version='0.11.0'
release='1'
desc='user-friendly инструмент для Linux для работы с доменом Active Directory и групповыми политиками.'
homepage='https://github.com/altlinux/admc.git'
architectures=('amd64')
license=('GPL-3.0-or-later')
provides=('admc')
conflicts=('admc')

deps_amd64=('smbldap-tools' 'samba' 'samba-devel' 'samba-libs' 'samba-client' 'samba-client-libs' 'samba-common' 'samba-common-libs' 'samba-common-tools' 'samba-dc' 'samba-dc-bind-dlz' 'samba-dc-libs' 'samba-dc-provision' 'krb5-devel' 'glib2' 'glib2-devel' 'uuid' 'uuid-devel' 'uuid-c++' 'uuid-c++-devel' 'uuidd' 'uuid-dce' 'uuid-dce-devel' 'smbldap-tools' 'libsmbclient' 'libsmbclient-devel' 'uuid-perl' 'libuuid' 'libuuid-devel')
deps_amd64_debian=('libldap-2.4-2' 'libsasl2-2' 'libsmbclient' 'libuuid1' 'libqt5help5' 'libkrb5-3')
build_deps=('cmake' 'gcc' 'gcc-c++' 'qt5-qtbase-devel' 'qt5-linguist')
build_deps_debian=('debhelper' 'cmake' 'qtbase5-dev' 'libqt5help5' 'qttools5-dev' 'libldap2-dev' 'pkg-config' 'samba-dev' 'libsmbclient-dev' 'libkrb5-dev' 'libglib2.0-dev' 'libsasl2-dev')

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
