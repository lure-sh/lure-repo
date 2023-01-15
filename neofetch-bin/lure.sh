name='neofetch-bin'
version='7.1.0'
release='1'
desc='Neofetch displays information about your operating system, software and hardware in an aesthetic and visually pleasing way.'
homepage='https://github.com/dylanaraps/neofetch'
maintainer="Евгений Храмов <xpamych@yandex.ru>"
architectures=('all')
license=('MIT')
provides=('neofetch')
conflicts=('neofetch')
deps=('bash')

sources=("https://github.com/dylanaraps/${provides}/archive/refs/tags/${version}.tar.gz")
checksums=('SKIP')

package() {
	install -Dm755 "${srcdir}/${provides}-${version}/neofetch" "${pkgdir}/usr/bin/neofetch"
	install -Dm755 "${srcdir}/${provides}-${version}/neofetch.1" "${pkgdir}/usr/man1/neofetch.1"
}
