name='zed-bin'
version=0.186.9
release=1
desc='A high-performance, multiplayer code editor from the creators of Atom and Tree-sitter'
maintainer='Elara Ivy <elara@elara.ws>'
homepage='https://zed.dev'
architectures=('amd64' 'arm64')
license=('GPL-3.0-or-later')
provides=('zed')
conflicts=('zed')

deps=('libasound2'
	'fontconfig'
	'libgcc-12-dev'
	'libc6'
	'libxcb1'
	'libxkbcommon0'
	'libxkbcommon-x11-0'
	'libssl3'
	'libsqlite3-0'
	'mesa-vulkan-drivers'
	'vulkan-tools'
	'libvulkan1'
	'libwayland-client0'
	'libwayland-cursor0'
	'libwayland-egl1'
	'zlib1g')

deps_arch=('alsa-lib'
         'fontconfig'
         'gcc-libs'
         'glibc'
         'libxcb'
         'libxkbcommon'
         'libxkbcommon-x11'
         'openssl'
         'sqlite'
         'vulkan-driver'
         'vulkan-icd-loader'
         'vulkan-tools'
         'wayland'
         'zlib')

sources_arm64=("https://zed.dev/api/releases/stable/$version/zed-linux-aarch64.tar.gz")
checksums_arm64=('44675edfebf91f60673c6a9c5aee87807e2e6050451374f0916c389187131429')

sources_amd64=("https://zed.dev/api/releases/stable/$version/zed-linux-x86_64.tar.gz")
checksums_amd64=('f36cc489a7e517928734a0a38bf86d776e4100324265eee3803f4fc86f48163d')

package() {
  cd zed.app
  sed -i "s|Exec=zed|Exec=/usr/lib/zed/zed-editor|g" "share/applications/zed.desktop"

	install-binary bin/zed zeditor
  install -Dm755 "libexec/zed-editor" "$pkgdir/usr/lib/zed/zed-editor"
	install-desktop share/applications/zed.desktop dev.zed.Zed.desktop
	install-license licenses.md zed-bin/LICENSE.md
  install-icon "share/icons/hicolor/512x512/apps/zed.png"
}
