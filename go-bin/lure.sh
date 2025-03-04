name="go-bin"
version=1.24.1
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
checksums_amd64=('cb2396bae64183cdccf81a9a6df0aea3bce9511fc21469fb89a0c00470088073')

sources_arm64=("https://dl.google.com/go/go${version}.linux-arm64.tar.gz")
checksums_arm64=('8df5750ffc0281017fb6070fba450f5d22b600a02081dceef47966ffaf36a3af')

sources_arm6=("https://dl.google.com/go/go${version}.linux-armv6l.tar.gz")
checksums_arm6=('6d95f8d7884bfe2364644c837f080f2b585903d0b771eb5b06044e226a4f120a')

sources_386=("https://dl.google.com/go/go${version}.linux-386.tar.gz")
checksums_386=('8c530ecedbc17e42ce10177bea07ccc96a3e77c792ea1ea72173a9675d16ffa5')

sources_riscv64=("https://dl.google.com/go/go${version}.linux-riscv64.tar.gz")
checksums_riscv64=('eaef4323d5467ff97fb1979c8491764060dade19f02f3275a9313f9a0da3b9c0')

package() {
	mkdir -p "$pkgdir/usr/lib/" "$pkgdir/usr/bin"
	cp -r "$srcdir/go" "$pkgdir/usr/lib/go"
	ln -s "$pkgdir/usr/lib/go/bin/go" "$pkgdir/usr/bin/go"
}
