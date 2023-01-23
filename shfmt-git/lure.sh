name='shfmt-git'
version='3241.08049c8'
release='1'
desc='A shell formatter. Supports POSIX Shell, Bash, and mksh.'
homepage='https://github.com/patrickvane/shfmt'
maintainer="Евгений Храмов <xpamych@yandex.ru>"
architectures=('all')
license=('BSD-3-Clause license')
provides=('shfmt')
conflicts=('shtmt')

sources=("git+https://github.com/patrickvane/shfmt.git")
checksums=('SKIP')

version() {
	cd "$srcdir/${provides}"
	git-version
}

build() {
	cd "$srcdir/shfmt/cmd/shfmt"
	go build
}

package() {
	install -Dm755 "$srcdir/shfmt/cmd/shfmt/shfmt" "${pkgdir}/usr/bin/shfmt"
}
