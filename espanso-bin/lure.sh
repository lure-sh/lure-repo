name='espanso-bin'
version='2.1.8'
release='1'
desc='Cross-platform Text Expander written in Rust'
homepage='https://espanso.org/'
architectures=('amd64')
license=('GPL3')
provides=("${pkgname%-bin}")
conflicts=("${pkgname%-bin}")

deps_amd64=('xdotool' 'xclip')

sources_amd64=("https://github.com/federico-terzi/espanso/releases/download/v${version}/Espanso-X11.AppImage"
	"https://raw.githubusercontent.com/federico-terzi/espanso/v${version}/espanso/src/res/linux/systemd.service")
checksums_amd64=('ad95210fcbcdf626624bb0f464839c5470a12f9243719492cd6a43607fdfdb70'
	'0448185f394858b1f06c6458869e932da317501759c3f018a696d7789b15e8b9')

prepare() {
	sed "s|{{{espanso_path}}}|/usr/bin/espanso|g" "systemd.service" >"systemd.service"
}

package() {
	install -Dm755 "Espanso-X11.AppImage" "${pkgdir}/usr/bin/espanso"
	install -Dm644 "systemd.service" "${pkgdir}/usr/lib/systemd/user/espanso.service"
}
