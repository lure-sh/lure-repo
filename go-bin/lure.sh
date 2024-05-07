name="go-bin"
version=1.22.3
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
checksums_amd64=('8920ea521bad8f6b7bc377b4824982e011c19af27df88a815e3586ea895f1b36')

sources_arm64=("https://dl.google.com/go/go${version}.linux-arm64.tar.gz")
checksums_arm64=('6c33e52a5b26e7aa021b94475587fce80043a727a54ceb0eee2f9fc160646434')

sources_arm6=("https://dl.google.com/go/go${version}.linux-armv6l.tar.gz")
checksums_arm6=('f2bacad20cd2b96f23a86d4826525d42b229fd431cc6d0dec61ff3bc448ef46e')

sources_386=("https://dl.google.com/go/go${version}.linux-386.tar.gz")
checksums_386=('fefba30bb0d3dd1909823ee38c9f1930c3dc5337a2ac4701c2277a329a386b57')

sources_riscv64=("https://dl.google.com/go/go${version}.linux-riscv64.tar.gz")
checksums_riscv64=('d4992d4a85696e3f1de06cefbfc2fd840c9c6695d77a0f35cfdc4e28b2121c20')

package() {
	mkdir -p "$pkgdir/usr/lib/" "$pkgdir/usr/bin"
	cp -r "$srcdir/go" "$pkgdir/usr/lib/go"
	ln -s "$pkgdir/usr/lib/go/bin/go" "$pkgdir/usr/bin/go"
}
