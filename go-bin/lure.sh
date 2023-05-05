name="go-bin"
version="1.20.4"
release=1
desc="Compiler and tools for the Go programming language"
desc_ru="Компилятор и инструменты для языка программирования Go"
homepage="https://go.dev/"
maintainer='Elara Musayelyan <elara@elara.ws>'
maintainer_ru='Элара Мусаелян <elara@elara.ws>'
architectures=('amd64' 'arm64' 'arm6' '386')
license=('BSD-3-Clause')
provides=('go' 'golang')
conflicts=('go' 'golang')

sources_amd64=("https://dl.google.com/go/go${version}.linux-amd64.tar.gz")
checksums_amd64=('698ef3243972a51ddb4028e4a1ac63dc6d60821bf18e59a807e051fee0a385bd')

sources_arm64=("https://dl.google.com/go/go${version}.linux-arm64.tar.gz")
checksums_arm64=('105889992ee4b1d40c7c108555222ca70ae43fccb42e20fbf1eebb822f5e72c6')

sources_arm6=("https://dl.google.com/go/go${version}.linux-armv6l.tar.gz")
checksums_arm6=('0b75ca23061a9996840111f5f19092a1bdbc42ec1ae25237ed2eec1c838bd819')

sources_386=("https://dl.google.com/go/go${version}.linux-386.tar.gz")
checksums_386=('5dfa3db9433ef6a2d3803169fb4bd2f4505414881516eb9972d76ab2e22335a7')

package() {
	mkdir -p "$pkgdir/usr/lib/" "$pkgdir/usr/bin"
	cp -r "$srcdir/go" "$pkgdir/usr/lib/go"
	ln -s "$pkgdir/usr/lib/go/bin/go" "$pkgdir/usr/bin/go"
}
