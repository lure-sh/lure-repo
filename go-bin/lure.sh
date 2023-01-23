name="go-bin"
version="1.19.5"
release=1
desc="Compiler and tools for the Go programming language"
desc_ru="Компилятор и инструменты для языка программирования Go"
homepage="https://go.dev/"
maintainer="Arsen Musayelyan <arsen@arsenm.dev>"
maintainer_ru="Арсен Мусаелян <arsen@arsenm.dev>"
architectures=('amd64' 'arm64' 'arm6' '386')
license=('BSD-3-Clause')
provides=('go' 'golang')
conflicts=('go' 'golang')

sources_amd64=("https://dl.google.com/go/go${version}.linux-amd64.tar.gz")
checksums_amd64=('36519702ae2fd573c9869461990ae550c8c0d955cd28d2827a6b159fda81ff95')

sources_arm64=("https://dl.google.com/go/go${version}.linux-arm64.tar.gz")
checksums_arm64=('fc0aa29c933cec8d76f5435d859aaf42249aa08c74eb2d154689ae44c08d23b3')

sources_arm6=("https://dl.google.com/go/go${version}.linux-armv6l.tar.gz")
checksums_arm6=('ec14f04bdaf4a62bdcf8b55b9b6434cc27c2df7d214d0bb7076a7597283b026a')

sources_386=("https://dl.google.com/go/go${version}.linux-386.tar.gz")
checksums_386=('f68331aa7458a3598060595f5601d5731fd452bb2c62ff23095ddad68854e510')

package() {
	mkdir -p "$pkgdir/usr/lib/" "$pkgdir/usr/bin"
	cp -r "$srcdir/go" "$pkgdir/usr/lib/go"
	ln -s "$pkgdir/usr/lib/go/bin/go" "$pkgdir/usr/bin/go"
}
