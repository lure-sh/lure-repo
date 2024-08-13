name="go-bin"
version=1.23.0
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
checksums_amd64=('905a297f19ead44780548933e0ff1a1b86e8327bb459e92f9c0012569f76f5e3')

sources_arm64=("https://dl.google.com/go/go${version}.linux-arm64.tar.gz")
checksums_arm64=('62788056693009bcf7020eedc778cdd1781941c6145eab7688bd087bce0f8659')

sources_arm6=("https://dl.google.com/go/go${version}.linux-armv6l.tar.gz")
checksums_arm6=('0efa1338e644d7f74064fa7f1016b5da7872b2df0070ea3b56e4fef63192e35b')

sources_386=("https://dl.google.com/go/go${version}.linux-386.tar.gz")
checksums_386=('0e8a7340c2632e6fb5088d60f95b52be1f8303143e04cd34e9b2314fafc24edd')

sources_riscv64=("https://dl.google.com/go/go${version}.linux-riscv64.tar.gz")
checksums_riscv64=('a87726205f1a283247f877ccae8ce147ff4e77ac802382647ac52256eb5642c7')

package() {
	mkdir -p "$pkgdir/usr/lib/" "$pkgdir/usr/bin"
	cp -r "$srcdir/go" "$pkgdir/usr/lib/go"
	ln -s "$pkgdir/usr/lib/go/bin/go" "$pkgdir/usr/bin/go"
}
