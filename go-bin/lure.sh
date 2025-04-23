name="go-bin"
version=1.24.2
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
checksums_amd64=('68097bd680839cbc9d464a0edce4f7c333975e27a90246890e9f1078c7e702ad')

sources_arm64=("https://dl.google.com/go/go${version}.linux-arm64.tar.gz")
checksums_arm64=('756274ea4b68fa5535eb9fe2559889287d725a8da63c6aae4d5f23778c229f4b')

sources_arm6=("https://dl.google.com/go/go${version}.linux-armv6l.tar.gz")
checksums_arm6=('438d5d3d7dcb239b58d893a715672eabe670b9730b1fd1c8fc858a46722a598a')

sources_386=("https://dl.google.com/go/go${version}.linux-386.tar.gz")
checksums_386=('4c382776d52313266f3026236297a224a6688751256a2dffa3f524d8d6f6c0ba')

sources_riscv64=("https://dl.google.com/go/go${version}.linux-riscv64.tar.gz")
checksums_riscv64=('91bda1558fcbd1c92769ad86c8f5cf796f8c67b0d9d9c19f76eecfc75ce71527')

package() {
	mkdir -p "$pkgdir/usr/lib/" "$pkgdir/usr/bin"
	cp -r "$srcdir/go" "$pkgdir/usr/lib/go"
	ln -s "$pkgdir/usr/lib/go/bin/go" "$pkgdir/usr/bin/go"
}
