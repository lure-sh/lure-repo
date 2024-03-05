name="go-bin"
version=1.22.1
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
checksums_amd64=('aab8e15785c997ae20f9c88422ee35d962c4562212bb0f879d052a35c8307c7f')

sources_arm64=("https://dl.google.com/go/go${version}.linux-arm64.tar.gz")
checksums_arm64=('e56685a245b6a0c592fc4a55f0b7803af5b3f827aaa29feab1f40e491acf35b8')

sources_arm6=("https://dl.google.com/go/go${version}.linux-armv6l.tar.gz")
checksums_arm6=('8cb7a90e48c20daed39a6ac8b8a40760030ba5e93c12274c42191d868687c281')

sources_386=("https://dl.google.com/go/go${version}.linux-386.tar.gz")
checksums_386=('8484df36d3d40139eaf0fe5e647b006435d826cc12f9ae72973bf7ec265e0ae4')

sources_riscv64=("https://dl.google.com/go/go${version}.linux-riscv64.tar.gz")
checksums_riscv64=('77f7c8d2a8ea10c413c1f86c1c42001cd98bf428239cabceda2cdaff2cf29330')

package() {
	mkdir -p "$pkgdir/usr/lib/" "$pkgdir/usr/bin"
	cp -r "$srcdir/go" "$pkgdir/usr/lib/go"
	ln -s "$pkgdir/usr/lib/go/bin/go" "$pkgdir/usr/bin/go"
}
