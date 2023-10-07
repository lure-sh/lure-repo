name='linux-user-repository-git'
version='328.7598122'
release=1
desc='Linux User REpository'
homepage='https://lure.sh'
maintainer='Elara Musayelyan <elara@elara.ws>'
maintainer_ru='Элара Мусаелян <elara@elara.ws>'
architectures=('amd64' 'arm64' 'arm7' 'arm6' '386' 'riscv64')
license=('GPL-3.0-or-later')
provides=('linux-user-repository')
conflicts=('linux-user-repository' 'linux-user-repository-bin' 'linux-user-repository-git')

build_deps=('golang')
build_deps_arch=('go')
build_deps_alpine=('go')
build_deps_opensuse=('go')

sources=("git+https://gitea.elara.ws/lure/lure.git")
checksums=('SKIP')

version() {
	cd "$srcdir/lure"
	git-version
}

prepare() {
	cd "$srcdir/lure"
	git-version > internal/config/version.txt
}

build() {
	cd "$srcdir/lure"
	CGO_ENABLED=0 go build
}

package() {
	cd "$srcdir/lure"
	install -Dm755 lure ${pkgdir}/usr/bin/lure
	install -Dm755 ./scripts/completion/bash ${pkgdir}/usr/share/bash-completion/completions/lure
	install -Dm755 ./scripts/completion/zsh ${pkgdir}/usr/share/zsh/site-functions/_lure
}
