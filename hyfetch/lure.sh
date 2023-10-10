name='hyfetch'
version='1.4.10'
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

sources=("https://files.pythonhosted.org/packages/source/H/HyFetch/HyFetch-${version}.tar.gz")
checksums=('blake2b-256:bf0413a5091a1da014fad160710abfad2aa03a72bc41e4678c95be2b5ee67818')


build() {
    cd "$srcdir/HyFetch-${version}"
    python3 setup.py build
}

package() {
	cd "$srcdir/HyFetch-${version}"
	python3 setup.py install --root="${pkgdir}/" --optimize=1 || return 1
}
