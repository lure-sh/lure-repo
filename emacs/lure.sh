name='emacs'
version='30.1'
release='0'
desc='GNU Emacs editor'
homepage='https://www.gnu.org/software/emacs/'
maintainer='Nil Geisweiller <ngeiswei@gmail.com>'
architectures=('amd64')
license=('GPL-3.0-or-later')
provides=('emacs')
conflicts=('emacs')

build_deps=('libxpm-dev' 'libgif-dev' 'libpng-dev' 'libtiff-dev' 'libgpm-dev' 'libselinux1-dev' 'libotf-dev' 'libgtk3.0-cil-dev' 'libm17n-dev' 'libxaw7-dev' 'libgnutls28-dev' 'libncurses-dev' 'autoconf' 'texinfo' 'make' 'gcc')

sources=("https://ftp.gnu.org/gnu/emacs/emacs-${version}.tar.xz")
checksums=('SKIP')

build() {
	cd "${srcdir}/emacs-${version}"
	./configure --prefix="${pkgdir}/usr"
	make -j
}

package() {
	cd "${srcdir}/emacs-${version}"
	make install
}
