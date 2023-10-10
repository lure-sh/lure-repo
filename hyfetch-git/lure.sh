name='hyfetch-git'
version='6457.5519dd1'
release='1'
desc='Neofetch with LGBTQ+ pride flags'
homepage='https://github.com/hykilpikonna/hyfetch'
maintainer='Elara Musayelyan <elara@elara.ws>'
maintainer_ru='Элара Мусаелян <elara@elara.ws>'
architectures=('all')
license=('MIT')
provides=('hyfetch' 'neowofetch')
conflicts=('hyfetch' 'neowofetch')

deps=("python3" "python3-typing-extensions" "bash")
deps_arch=("python" "python-typing_extensions" "bash")
deps_alpine=("python3" "py3-typing-extensions" "bash")

build_deps=("python3" "python3-setuptools" "python3-typing-extensions")
build_deps_arch=("python" "python-setuptools" "python-typing_extensions")
build_deps_alpine=("python3" "py3-setuptools" "py3-typing-extensions")

sources=("git+https://github.com/hykilpikonna/hyfetch.git")
checksums=('SKIP')

version() {
	cd "$srcdir/hyfetch"
	git-version
}

build() {
	cd "$srcdir/hyfetch"
	python3 setup.py build
}

package() {
	cd "$srcdir/hyfetch"
	python3 setup.py install --root="${pkgdir}/" --optimize=1 || return 1
}
