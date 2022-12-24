name='tuntox-git'
version='r269.ef1f283'
release=1
desc='Tunnel TCP connections over the Tox protocol'
homepage='https://github.com/gjedeer/tuntox'
architectures=('amd64' 'arm64' 'arm7' 'arm6' '386')
license=('GPL-3.0-or-later')
provides=('tuntox')
conflicts=('tuntox')

build_deps=('libtoxcore-dev')
build_deps_fedora=('toxcore-devel')
build_deps_opensuse=('toxcore-devel')
build_deps_arch=('toxcore')

deps=('toxcore')
deps_debian=('libtoxcore2')

sources=('git+https://github.com/gjedeer/tuntox.git')
checksums=('SKIP')

version() {
	cd "$srcdir/tuntox"
	printf "r%s.%s" "$(git rev-list --count HEAD)" "$(git rev-parse --short HEAD)"
}

build() {
	cd "$srcdir/tuntox"
	make tuntox_nostatic
}

package() {
	cd "$srcdir/tuntox"
	make DESTDIR="${pkgdir}" install
}
