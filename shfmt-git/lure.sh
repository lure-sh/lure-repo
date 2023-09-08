name='shfmt-git'
version='3570.6fe8d00'
release='1'
desc='Format shell programs'
homepage='https://github.com/mvdan/sh'
maintainer="Elara Musayelyan <elara@elara.ws>"
maintainer_ru='Элара Мусаелян <elara@elara.ws>'
architectures=('amd64' 'arm64' 'arm' '386' 'riscv64')
license=('BSD-3-Clause license')
provides=('shfmt')
conflicts=('shtmt')

build_deps=('golang')
build_deps_arch=('go')
build_deps_alpine=('go')
build_deps_opensuse=('go')

sources=("git+https://github.com/mvdan/sh.git")
checksums=('SKIP')

version() {
	cd "$srcdir/sh"
	git-version
}

build() {
	cd "$srcdir/sh"
	go build ./cmd/shfmt
}

package() {
	install-binary "$srcdir/sh/shfmt"
}
