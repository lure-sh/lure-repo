name="go-bin"
version=1.21.0
release=2
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
checksums_amd64=('d0398903a16ba2232b389fb31032ddf57cac34efda306a0eebac34f0965a0742')

sources_arm64=("https://dl.google.com/go/go${version}.linux-arm64.tar.gz")
checksums_arm64=('f3d4548edf9b22f26bbd49720350bbfe59d75b7090a1a2bff1afad8214febaf3')

sources_arm6=("https://dl.google.com/go/go${version}.linux-armv6l.tar.gz")
checksums_arm6=('e377a0004957c8c560a3ff99601bce612330a3d95ba3b0a2ae144165fc87deb1')

sources_386=("https://dl.google.com/go/go${version}.linux-386.tar.gz")
checksums_386=('0e6f378d9b072fab0a3d9ff4d5e990d98487d47252dba8160015a61e6bd0bcba')

sources_riscv64=("https://dl.google.com/go/go${version}.linux-riscv64.tar.gz")
checksums_riscv64=('87b21c06573617842ca9e00b954bc9f534066736a0778eae594ac54b45a9e8b7')

package() {
	mkdir -p "$pkgdir/usr/lib/" "$pkgdir/usr/bin"
	cp -r "$srcdir/go" "$pkgdir/usr/lib/go"
	ln -s "$pkgdir/usr/lib/go/bin/go" "$pkgdir/usr/bin/go"
}
