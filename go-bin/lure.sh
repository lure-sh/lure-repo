name="go-bin"
version=1.23.5
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
checksums_amd64=('cbcad4a6482107c7c7926df1608106c189417163428200ce357695cc7e01d091')

sources_arm64=("https://dl.google.com/go/go${version}.linux-arm64.tar.gz")
checksums_arm64=('47c84d332123883653b70da2db7dd57d2a865921ba4724efcdf56b5da7021db0')

sources_arm6=("https://dl.google.com/go/go${version}.linux-armv6l.tar.gz")
checksums_arm6=('04e0b5cf5c216f0aa1bf8204d49312ad0845800ab0702dfe4357c0b1241027a3')

sources_386=("https://dl.google.com/go/go${version}.linux-386.tar.gz")
checksums_386=('6ecf6a41d0925358905fa2641db0e1c9037aa5b5bcd26ca6734caf50d9196417')

sources_riscv64=("https://dl.google.com/go/go${version}.linux-riscv64.tar.gz")
checksums_riscv64=('d9da15778442464f32acfa777ac731fd4d47362b233b83a0932380cb6d2d5dc8')

package() {
	mkdir -p "$pkgdir/usr/lib/" "$pkgdir/usr/bin"
	cp -r "$srcdir/go" "$pkgdir/usr/lib/go"
	ln -s "$pkgdir/usr/lib/go/bin/go" "$pkgdir/usr/bin/go"
}
