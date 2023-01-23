name='itgui-git'
version='99.08113c2'
release=1
desc='GUI client for ITD'
homepage='https://gitea.arsenm.dev/Arsen6331/itd'
architectures=('amd64' 'arm64' 'arm7' 'arm6' '386')
license=('GPL-3.0-or-later')
provides=('itgui')
conflicts=('itgui')

build_deps=('golang' 'gcc' 'libgl1-mesa-dev' 'xorg-dev')
build_deps_arch=('go' 'gcc' 'xorg-server-devel' 'libxcursor' 'libxrandr' 'libxinerama' 'libxi' 'libglvnd')
build_deps_alpine=('go' 'gcc' 'libxcursor-dev' 'libxrandr-dev' 'libxinerama-dev' 'libxi-dev' 'linux-headers' 'mesa-dev')
build_deps_opensuse=('go' 'gcc' 'libXcursor-devel' 'libXrandr-devel' 'libXi-devel' 'libXinerama-devel' 'libXxf86vm-devel' 'Mesa-libGL-devel')
build_deps_fedora=('golang' 'gcc' 'libXcursor-devel' 'libXrandr-devel' 'libXi-devel' 'libXinerama-devel' 'libXxf86vm-devel' 'mesa-libGL-devel')

deps=('libxcursor1' 'libxrandr2' 'libxinerama1' 'libxi6' 'libgl1')
deps_arch=('libxcursor' 'libxrandr' 'libxinerama' 'libxi' 'libglvnd')
deps_alpine=('libxcursor' 'libxrandr' 'libxinerama' 'libxi' 'mesa-gl')
deps_opensuse=('libXcursor1' 'libXrandr2' 'libXinerama1' 'libXi6' 'Mesa-libGL1')
deps_fedora=('libXcursor' 'libXrandr' 'libXinerama' 'libXi' 'mesa-libGL')

sources=("git+https://gitea.arsenm.dev/Arsen6331/itd.git")
checksums=('SKIP')

backup=('/etc/itd.toml')

version() {
	cd "$srcdir/itd"
	git-version
}

build() {
	cd "$srcdir/itd"
	go build ./cmd/itgui
}

package() {
	cd "$srcdir/itd"
	install-desktop ./itgui.desktop
	install-binary ./itgui
}
