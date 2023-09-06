name="go-bin"
version=1.21.1
release=1
desc="Compiler and tools for the Go programming language"
desc_ru="Компилятор и инструменты для языка программирования Go"
homepage="https://go.dev/"
maintainer='Elara Musayelyan <elara@elara.ws>'
maintainer_ru='Элара Мусаелян <elara@elara.ws>'
architectures=('amd64' 'arm64' 'arm6' '386' 'riscv64')
license=('BSD-3-Clause')
provides=('go' 'golang')
conflicts=('go' 'golang' 'golang-bin' 'golang-go')

sources_amd64=("https://dl.google.com/go/go${version}.linux-amd64.tar.gz")
checksums_amd64=('b3075ae1ce5dab85f89bc7905d1632de23ca196bd8336afd93fa97434cfa55ae')

sources_arm64=("https://dl.google.com/go/go${version}.linux-arm64.tar.gz")
checksums_arm64=('7da1a3936a928fd0b2602ed4f3ef535b8cd1990f1503b8d3e1acc0fa0759c967')

sources_arm6=("https://dl.google.com/go/go${version}.linux-armv6l.tar.gz")
checksums_arm6=('f3716a43f59ae69999841d6007b42c9e286e8d8ce470656fb3e70d7be2d7ca85')

sources_386=("https://dl.google.com/go/go${version}.linux-386.tar.gz")
checksums_386=('b93850666cdadbd696a986cf7b03111fe99db8c34a9aaa113d7c96d0081e1901')

sources_riscv64=("https://dl.google.com/go/go${version}.linux-riscv64.tar.gz")
checksums_riscv64=('fac64ed26e003f49f1d77f6d2c4cf951422aecbce12232d9ec1bf4585fc44ee1')

package() {
	mkdir -p "$pkgdir/usr/lib/" "$pkgdir/usr/bin"
	cp -r "$srcdir/go" "$pkgdir/usr/lib/go"
	ln -s "$pkgdir/usr/lib/go/bin/go" "$pkgdir/usr/bin/go"
}
