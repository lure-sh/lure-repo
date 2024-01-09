name="go-bin"
version=1.21.6
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
checksums_amd64=('3f934f40ac360b9c01f616a9aa1796d227d8b0328bf64cb045c7b8c4ee9caea4')

sources_arm64=("https://dl.google.com/go/go${version}.linux-arm64.tar.gz")
checksums_arm64=('e2e8aa88e1b5170a0d495d7d9c766af2b2b6c6925a8f8956d834ad6b4cacbd9a')

sources_arm6=("https://dl.google.com/go/go${version}.linux-armv6l.tar.gz")
checksums_arm6=('6a8eda6cc6a799ff25e74ce0c13fdc1a76c0983a0bb07c789a2a3454bf6ec9b2')

sources_386=("https://dl.google.com/go/go${version}.linux-386.tar.gz")
checksums_386=('05d09041b5a1193c14e4b2db3f7fcc649b236c567f5eb93305c537851b72dd95')

sources_riscv64=("https://dl.google.com/go/go${version}.linux-riscv64.tar.gz")
checksums_riscv64=('86a2fe6597af4b37d98bca632f109034b624786a8d9c1504d340661355ed31f7')

package() {
	mkdir -p "$pkgdir/usr/lib/" "$pkgdir/usr/bin"
	cp -r "$srcdir/go" "$pkgdir/usr/lib/go"
	ln -s "$pkgdir/usr/lib/go/bin/go" "$pkgdir/usr/bin/go"
}
