name="go-bin"
version=1.22.2
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
checksums_amd64=('5901c52b7a78002aeff14a21f93e0f064f74ce1360fce51c6ee68cd471216a17')

sources_arm64=("https://dl.google.com/go/go${version}.linux-arm64.tar.gz")
checksums_arm64=('36e720b2d564980c162a48c7e97da2e407dfcc4239e1e58d98082dfa2486a0c1')

sources_arm6=("https://dl.google.com/go/go${version}.linux-armv6l.tar.gz")
checksums_arm6=('9243dfafde06e1efe24d59df6701818e6786b4adfdf1191098050d6d023c5369')

sources_386=("https://dl.google.com/go/go${version}.linux-386.tar.gz")
checksums_386=('586d9eb7fe0489ab297ad80dd06414997df487c5cf536c490ffeaa8d8f1807a7')

sources_riscv64=("https://dl.google.com/go/go${version}.linux-riscv64.tar.gz")
checksums_riscv64=('2e0447ed3294729232e012898a43145defaf2ffbfece2e934edda8bd2775c400')

package() {
	mkdir -p "$pkgdir/usr/lib/" "$pkgdir/usr/bin"
	cp -r "$srcdir/go" "$pkgdir/usr/lib/go"
	ln -s "$pkgdir/usr/lib/go/bin/go" "$pkgdir/usr/bin/go"
}
