name="img2pdf+"
version=1.1.3
release=3
desc="Merge images into one pdf file via command line."
homepage="https://github.com/Elagoht/img2pdf-plus"
architectures=("all")
license=("MIT")
maintainer="Furkan Baytekin (Elagoht) <furkanbaytekin@gmail.com>"
provides=("img2pdf+")
build_deps=("python3" "python3-pip" "python3-venv")
build_deps_debian=("python3" "python3-venv" "python3-pip")
build_deps_arch=("python" "python-pip" "python-virtualenv")
build_deps_opensuse=("python3" "python-pip" "python-virtualenv")
sources=("git+https://github.com/Elagoht/img2pdf-plus")
checksums=("SKIP")
version() {
	printf "%s" $version
}
prepare() {
	cd "$srcdir/img2pdf-plus/"
	python3 -m venv builder
	source builder/bin/activate
	pip install pillow python-magic fpdf2 fonttools pyinstaller
}
build() {
	cd "$srcdir/img2pdf-plus/"
	$srcdir/img2pdf-plus/builder/bin/pyinstaller --onefile src/img2pdf/main.py --name=img2pdf+
}
package() {
	install -d "$pkgdir/usr/bin/"
	install -Dm755 "$srcdir/img2pdf-plus/dist/img2pdf+" -t "$pkgdir/usr/bin/"
	#rm -rf "$srcdir/img2pdf-plus"
}

