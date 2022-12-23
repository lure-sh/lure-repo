name="go-bin"
version="1.19.4"
release=1
desc="Compiler and tools for the Go programming language"
homepage="https://go.dev/"
maintainer="Arsen Musayelyan <arsen@arsenm.dev>"
architectures=('amd64' 'arm64' 'arm6' '386')
license=('BSD-3-Clause')
provides=('go' 'golang')
conflicts=('go' 'golang')

sources_amd64=("https://dl.google.com/go/go${version}.linux-amd64.tar.gz")
checksums_amd64=('c9c08f783325c4cf840a94333159cc937f05f75d36a8b307951d5bd959cf2ab8')

sources_arm64=("https://dl.google.com/go/go${version}.linux-arm64.tar.gz")
checksums_arm64=('9df122d6baf6f2275270306b92af3b09d7973fb1259257e284dba33c0db14f1b')

sources_arm6=("https://dl.google.com/go/go${version}.linux-armv6l.tar.gz")
checksums_arm6=('7a51dae4f3a52d2dfeaf59367cc0b8a296deddc87e95aa619bf87d24661d2370')

sources_386=("https://dl.google.com/go/go${version}.linux-386.tar.gz")
checksums_386=('e5f0b0551e120bf3d1246cb960ec58032d7ca69e1adcf0fdb91c07da620e0c61')

package() {
	mkdir -p "$pkgdir/usr/lib/" "$pkgdir/usr/bin"
	cp -r "$srcdir/go" "$pkgdir/usr/lib/go"
	ln -s "$pkgdir/usr/lib/go/bin/go" "$pkgdir/usr/bin/go"
}
