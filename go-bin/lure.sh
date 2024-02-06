name="go-bin"
version=1.22.0
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
checksums_amd64=('f6c8a87aa03b92c4b0bf3d558e28ea03006eb29db78917daec5cfb6ec1046265')

sources_arm64=("https://dl.google.com/go/go${version}.linux-arm64.tar.gz")
checksums_arm64=('6a63fef0e050146f275bf02a0896badfe77c11b6f05499bb647e7bd613a45a10')

sources_arm6=("https://dl.google.com/go/go${version}.linux-armv6l.tar.gz")
checksums_arm6=('0525f92f79df7ed5877147bce7b955f159f3962711b69faac66bc7121d36dcc4')

sources_386=("https://dl.google.com/go/go${version}.linux-386.tar.gz")
checksums_386=('1e209c4abde069067ac9afb341c8003db6a210f8173c77777f02d3a524313da3')

sources_riscv64=("https://dl.google.com/go/go${version}.linux-riscv64.tar.gz")
checksums_riscv64=('afe9cedcdbd6fdff27c57efd30aa5ce0f666f471fed5fa96cd4fb38d6b577086')

package() {
	mkdir -p "$pkgdir/usr/lib/" "$pkgdir/usr/bin"
	cp -r "$srcdir/go" "$pkgdir/usr/lib/go"
	ln -s "$pkgdir/usr/lib/go/bin/go" "$pkgdir/usr/bin/go"
}
