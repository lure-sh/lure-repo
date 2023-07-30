name="pomodoit-bin"
version=1.0
release=1
desc="Track your todos with pomodoro clock"
homepage="https://github.com/Elagoht/PomoDoIt"
architectures=("amd64")
license=("GPL")
maintainer="Furkan Baytekin (Elagoht) <furkanbaytekin@gmail.com>"
provides=("pomodoit")
build_deps_debian=("libgtk-3-0" "libwebkit2gtk-4.0-37")
build_deps_arch=("gtk3" "webkit2gtk")
build_deps_opensuse=("libgtk-3-0" "libwebkit2gtk-4_0-37")
sources_amd64=("https://github.com/Elagoht/PomoDoIt/releases/download/v$version/pomodoit.tar.gz")
checksums_amd64=("f054c3a31c43df9fd7df003ddca7c859f12b0cc1067f1030a1adfc7012e4878f")
version() {
	printf "%s" $version
}
package() {
	install -d $pkgdir/usr/bin
	install -d $pkgdir/usr/share/icons
	install -d $pkgdir/usr/share/applications
	install -D $srcdir/usr/bin/pomodoit -t $pkgdir/usr/bin/
	install -D $srcdir/usr/share/applications/pomodoit.desktop -t $pkgdir/usr/share/applications/
	install -D $srcdir/usr/share/icons/hicolor/32x32/apps/pomodoit.png \
		-t $pkgdir/usr/share/icons/hicolor/32x32/apps/
	install -D $srcdir/usr/share/icons/hicolor/128x128/apps/pomodoit.png \
		-t $pkgdir/usr/share/icons/hicolor/128x128/apps/
	install -D $srcdir/usr/share/icons/hicolor/256x256@2/apps/pomodoit.png \
		-t $pkgdir/usr/share/icons/hicolor/256x256@2/apps//
}
