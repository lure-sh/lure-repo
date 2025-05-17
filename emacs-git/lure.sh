name='emacs-git'
version='30.0.50'
release='0'
desc='GNU Emacs editor'
homepage='https://www.gnu.org/software/emacs/'
maintainer='Nil Geisweiller <ngeiswei@gmail.com>'
architectures=('amd64')
license=('GPL-3.0-or-later')
provides=('emacs')
conflicts=('emacs')

build_deps=('libxpm-dev' 'libgif-dev' 'libpng-dev' 'libtiff-dev' 'libgpm-dev' 'libselinux1-dev' 'libotf-dev' 'libgtk3.0-cil-dev' 'libm17n-dev' 'libxaw7-dev' 'libgnutls28-dev' 'libncurses-dev' 'autoconf' 'texinfo' 'make' 'gcc')

sources=("git+https://git.savannah.gnu.org/git/emacs.git")
checksums=('SKIP')

version() {
	cd "${srcdir}/emacs"
	git-version
}

prepare() {
	cd "${srcdir}/emacs"
	./autogen.sh
}

build() {
	cd "${srcdir}/emacs"
	./configure --prefix="${pkgdir}/usr"
	make -j
}

package() {
	cd "${srcdir}/emacs"
	make install
}
