name='cava'
version='0.9.1'
release='1'
desc='Cross-platform Audio Visualizer'
homepage='https://github.com/karlstav/cava'
maintainer="karl stav <karl@stavestrand.no>"
architectures=('amd64')
license=('MIT')
provides=('cava')
conflicts=('cava')
deps=('')
build_deps_debian=('build-essential libfftw3-dev libasound2-dev libncursesw5-dev libpulse-dev libtool automake autoconf-archive libiniparser-dev libsdl2-2.0-0 libsdl2-dev libpipewire-0.3-dev pkgconf')
build_deps_arch=('base-devel fftw ncurses alsa-lib iniparser autoconf-archive pkgconf')
build_deps_opensuse=('alsa-devel ncurses-devel fftw3-devel libpulse-devel libtool autoconf-archive pkgconf')
sources=("git+https://github.com/karlstav/cava.git")
checksums=('SKIP')

version() {
	cd "$srcdir"
	git-version
}

build() {
    ./autogen.sh
    ./configure
    make
}

package() {
	install -Dm755 "${srcdir}/cava" "${pkgdir}/usr/bin/cava"
}
