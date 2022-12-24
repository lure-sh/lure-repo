name='lure-git'
version'88.d32437e'
release=1
desc='Linux User REpository'
homepage='https://gitea.arsenm.dev/Arsen6331/lure'
architectures=('amd64' 'arm64' 'arm7' 'arm6' '386' 'riscv64')
license=('GPL-3.0-or-later')
provides=('lure')
conflicts=('lure')

build_deps=('golang')
build_deps_arch=('go')
build_deps_alpine=('go')
build_deps_opensuse=('go')

sources=("git+https://gitea.arsenm.dev/Arsen6331/lure.git")
checksums=('SKIP')

version() {
	cd "$srcdir/lure"
	git-version
}

build() {
	cd "$srcdir/lure"
	go build
}

package() {
	cd "$srcdir/lure"
	install -Dm755 lure ${pkgdir}/usr/bin/lure
}
