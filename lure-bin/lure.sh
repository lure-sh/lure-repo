name='lure-bin'
version=0.0.5
release=1
desc='Linux User REpository'
homepage='https://gitea.arsenm.dev/Arsen6331/lure'
architectures=('amd64' 'arm64' 'riscv64')
license=('GPL-3.0-or-later')
provides=('lure')
conflicts=('lure')

sources_arm64=("https://gitea.arsenm.dev/Arsen6331/lure/releases/download/v0.0.5/lure_0.0.5_linux_aarch64.tar.gz")
checksums_arm64=('da00720af03b48b38fbc44dd05b9c0787907f7abe0a1fd41a5e6fa0d1e705563')

sources_amd64=("https://gitea.arsenm.dev/Arsen6331/lure/releases/download/v0.0.5/lure_0.0.5_linux_x86_64.tar.gz")
checksums_amd64=('fc64d7aacff2318b1617e2268a9c08975813e2ea1d1717cf24e55dcb6c1b2e27')

sources_riscv64=("https://gitea.arsenm.dev/Arsen6331/lure/releases/download/v0.0.5/lure_0.0.5_linux_riscv64.tar.gz")
checksums_riscv64=('581098bc4bc8b5cf9870f1b00ae722f59106ccd5c8a337ff06c11b6e230b2eed')

package() {
	install-binary ./lure
}
