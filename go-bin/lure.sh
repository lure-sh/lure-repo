name="go-bin"
version="1.20.3"
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
checksums_amd64=('979694c2c25c735755bf26f4f45e19e64e4811d661dd07b8c010f7a8e18adfca')

sources_arm64=("https://dl.google.com/go/go${version}.linux-arm64.tar.gz")
checksums_arm64=('eb186529f13f901e7a2c4438a05c2cd90d74706aaa0a888469b2a4a617b6ee54')

sources_arm6=("https://dl.google.com/go/go${version}.linux-armv6l.tar.gz")
checksums_arm6=('b421e90469a83671641f81b6e20df6500f033e9523e89cbe7b7223704dd1035c')

sources_386=("https://dl.google.com/go/go${version}.linux-386.tar.gz")
checksums_386=('e12384311403f1389d14cc1c1295bfb4e0dd5ab919403b80da429f671a223507')

package() {
	mkdir -p "$pkgdir/usr/lib/" "$pkgdir/usr/bin"
	cp -r "$srcdir/go" "$pkgdir/usr/lib/go"
	ln -s "$pkgdir/usr/lib/go/bin/go" "$pkgdir/usr/bin/go"
}
