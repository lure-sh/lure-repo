name="go-bin"
version=1.20.5
release=1
desc="Compiler and tools for the Go programming language"
desc_ru="Компилятор и инструменты для языка программирования Go"
homepage="https://go.dev/"
maintainer='Elara Musayelyan <elara@elara.ws>'
maintainer_ru='Элара Мусаелян <elara@elara.ws>'
architectures=('amd64' 'arm64' 'arm6' '386')
license=('BSD-3-Clause')
provides=('go' 'golang')
conflicts=('go' 'golang' 'golang-bin' 'golang-go')

sources_amd64=("https://dl.google.com/go/go${version}.linux-amd64.tar.gz")
checksums_amd64=('d7ec48cde0d3d2be2c69203bc3e0a44de8660b9c09a6e85c4732a3f7dc442612')

sources_arm64=("https://dl.google.com/go/go${version}.linux-arm64.tar.gz")
checksums_arm64=('aa2fab0a7da20213ff975fa7876a66d47b48351558d98851b87d1cfef4360d09')

sources_arm6=("https://dl.google.com/go/go${version}.linux-armv6l.tar.gz")
checksums_arm6=('79d8210efd4390569912274a98dffc16eb85993cccdeef4d704e9b0dfd50743a')

sources_386=("https://dl.google.com/go/go${version}.linux-386.tar.gz")
checksums_386=('d394ac8fecf66812c78ffba7fb9a265bb1b9917564c7fd77f0edb0df6d5777a1')

package() {
	mkdir -p "$pkgdir/usr/lib/" "$pkgdir/usr/bin"
	cp -r "$srcdir/go" "$pkgdir/usr/lib/go"
	ln -s "$pkgdir/usr/lib/go/bin/go" "$pkgdir/usr/bin/go"
}
