name="img2pdf+"
version=1.1
release=1
desc="Merge images into one pdf file via command line. "
homepage="https://github.com/Elagoht/img2pdf"
architectures=("all")
license="GPLv3"
maintainer="Furkan Baytekin (Elagoht)"
provides="img2pdf+"
build_deps=("python3" "python3-pip")
build_deps_arch=("python" "python-pip")
build_deps_opensuse=("python3" "python-pip")
sources=("git+https://github.com/Elagoht/img2pdf")
checksums="SKIP"
version() {
	cd "$srcdir/img2pdf"
	printf "r%s.%s" "$(git rev-list --count HEAD)" "$(git rev-parse --short HEAD)"
}
prepare() {
    cd "$srcdir/img2pdf/"
    python3 -m venv builder
    source builder/bin/activate
    pip install pillow python-magic fpdf2 fonttools pyinstaller
}
build() {
    cd "$srcdir/img2pdf/"
    python -m PyInstaller --onefile img2pdf.py
}
package() {
    install -d "$pkgdir/usr/bin/"
    install -Dm755 "$srcdir/img2pdf/dist/img2pdf" -t "$pkgdir/usr/bin/"
    rm -rf "$srcdir/img2pdf"
}
