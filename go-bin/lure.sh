name="go-bin"
version="1.20.1"
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
checksums_amd64=('000a5b1fca4f75895f78befeb2eecf10bfff3c428597f3f1e69133b63b911b02')

sources_arm64=("https://dl.google.com/go/go${version}.linux-arm64.tar.gz")
checksums_arm64=('5e5e2926733595e6f3c5b5ad1089afac11c1490351855e87849d0e7702b1ec2e')

sources_arm6=("https://dl.google.com/go/go${version}.linux-armv6l.tar.gz")
checksums_arm6=('e4edc05558ab3657ba3dddb909209463cee38df9c1996893dd08cde274915003')

sources_386=("https://dl.google.com/go/go${version}.linux-386.tar.gz")
checksums_386=('3a7345036ebd92455b653e4b4f6aaf4f7e1f91f4ced33b23d7059159cec5f4d7')

package() {
	mkdir -p "$pkgdir/usr/lib/" "$pkgdir/usr/bin"
	cp -r "$srcdir/go" "$pkgdir/usr/lib/go"
	ln -s "$pkgdir/usr/lib/go/bin/go" "$pkgdir/usr/bin/go"
}
