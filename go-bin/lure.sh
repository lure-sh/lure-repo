name="go-bin"
version=1.22.6
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
checksums_amd64=('999805bed7d9039ec3da1a53bfbcafc13e367da52aa823cb60b68ba22d44c616')

sources_arm64=("https://dl.google.com/go/go${version}.linux-arm64.tar.gz")
checksums_arm64=('c15fa895341b8eaf7f219fada25c36a610eb042985dc1a912410c1c90098eaf2')

sources_arm6=("https://dl.google.com/go/go${version}.linux-armv6l.tar.gz")
checksums_arm6=('b566484fe89a54c525dd1a4cbfec903c1f6e8f0b7b3dbaf94c79bc9145391083')

sources_386=("https://dl.google.com/go/go${version}.linux-386.tar.gz")
checksums_386=('9e680027b058beab10ce5938607660964b6d2c564bf50bdb01aa090dc5beda98')

sources_riscv64=("https://dl.google.com/go/go${version}.linux-riscv64.tar.gz")
checksums_riscv64=('30be9c9b9cc4f044d4da9a33ee601ab7b3aff4246107d323a79e08888710754e')

package() {
	mkdir -p "$pkgdir/usr/lib/" "$pkgdir/usr/bin"
	cp -r "$srcdir/go" "$pkgdir/usr/lib/go"
	ln -s "$pkgdir/usr/lib/go/bin/go" "$pkgdir/usr/bin/go"
}
