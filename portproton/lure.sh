name='portproton'
version='1.0'
release='1'
desc='PortProton is a project designed to make it easy and convenient to run Windows games on Linux for both beginners and advanced users.'
homepage='https://linux-gaming.ru/'
architectures=('all')
licenses='MIT'
provides=('portproton')
conflicts=('portproton')

deps_redos=('bubblewrap' 'cabextract' 'curl' 'icoutils' 'vulkan-loader' 'vulkan-loader(x86-32)' 'vulkan-tools' 'wget' 'zenity' 'zstd')
deps_arch=('bash' 'icoutils' 'wget' 'bubblewrap' 'zstd' 'cabextract' 'bc' 'tar' 'openssl' 'gamemode' 'desktop-file-utils'
	'curl' 'dbus' 'freetype2' 'gdk-pixbuf2' 'ttf-font' 'zenity' 'lsb-release' 'nss' 'xorg-xrandr' 'vulkan-driver' 'vulkan-icd-loader'
	'lsof' 'lib32-freetype2' 'lib32-libgl' 'lib32-gcc-libs' 'lib32-libx11' 'lib32-libxss' 'lib32-alsa-plugins' 'lib32-libgpg-error'
	'lib32-nss' 'lib32-vulkan-driver' 'lib32-vulkan-icd-loader' 'lib32-gamemode' 'lib32-openssl')
deps_debian=('curl' 'zenity' 'cabextract' 'bubblewrap' 'gamemode' 'icoutils' 'tar' 'wget' 'zstd' 'libvulkan1')
deps_fedora=('curl' 'gamemode' 'icoutils' 'libcurl' 'wget' 'zenity' 'bubblewrap' 'zstd' 'cabextract' 'tar' 'goverlay' 'openssl'
	'vulkan-loader(x86-32)' 'vulkan-loader' 'mesa-vulkan-drivers' 'mesa-vulkan-drivers(x86-32)' 'mesa-libGL' 'mesa-dri-drivers' 'mesa-dri-drivers(x86-32)')
sources=(
	"https://raw.githubusercontent.com/Castro-Fidel/PortWINE/master/portwine_install_script/PortProton_1.0"
	"git+https://github.com/Castro-Fidel/PortProton_PKGBUILD.git"
)

checksums=(
	'SKIP'
	'SKIP'
)

prepare() {
	cd "${srcdir}"
	if grep -q ID=debian "/etc/os-release"; then
		sudo dpkg --add-architecture i386
		sudo apt-get install libvulkan1:i386
		sudo apt-get update
	elif grep -q ID=fedora "/etc/os-release"; then
		sudo dnf install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
		sudo dnf update
		sudo dnf upgrade --refresh
	fi
}

package() {
	install -Dm755 "PortProton_${version}" "${pkgdir}/usr/bin/${name}"
	install -Dm644 "./PortProton_PKGBUILD/${name}.desktop" -t "${pkgdir}/usr/share/applications/"
	install -Dm644 "./PortProton_PKGBUILD/${name}.png" -t "${pkgdir}/usr/share/pixmaps"
	install -Dm644 "./PortProton_PKGBUILD/LICENSE" -t "${pkgdir}/usr/share/licenses/${name}/"
}
