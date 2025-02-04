name="go-bin"
version=1.23.6
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
checksums_amd64=('9379441ea310de000f33a4dc767bd966e72ab2826270e038e78b2c53c2e7802d')

sources_arm64=("https://dl.google.com/go/go${version}.linux-arm64.tar.gz")
checksums_arm64=('561c780e8f4a8955d32bf72e46af0b5ee5e0debe1e4633df9a03781878219202')

sources_arm6=("https://dl.google.com/go/go${version}.linux-armv6l.tar.gz")
checksums_arm6=('27a4611010c16b8c4f37ade3aada55bd5781998f02f348b164302fd5eea4eb74')

sources_386=("https://dl.google.com/go/go${version}.linux-386.tar.gz")
checksums_386=('e61f87693169c0bbcc43363128f1e929b9dff0b7f448573f1bdd4e4a0b9687ba')

sources_riscv64=("https://dl.google.com/go/go${version}.linux-riscv64.tar.gz")
checksums_riscv64=('f95f7f817ab22ecab4503d0704d6449ea1aa26a595f57bf9b9f94ddf2aa7c1f3')

package() {
	mkdir -p "$pkgdir/usr/lib/" "$pkgdir/usr/bin"
	cp -r "$srcdir/go" "$pkgdir/usr/lib/go"
	ln -s "$pkgdir/usr/lib/go/bin/go" "$pkgdir/usr/bin/go"
}
