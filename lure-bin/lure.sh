name='lure-bin'
version=0.0.4
release=1
desc='Linux User REpository'
homepage='https://gitea.arsenm.dev/Arsen6331/lure'
architectures=('amd64' 'aarch64' 'arm7' 'arm6' '386' 'riscv64')
license=('GPL-3.0-or-later')
provides=('lure')
conflicts=('lure')

sources_arm64=("https://gitea.arsenm.dev/Arsen6331/lure/releases/download/v0.0.4/lure_0.0.4_linux_aarch64.tar.gz")
checksums_arm64=('a87bf7a78c6a87576bcf48c85b38d59fee0d102e372e3ed0a3626394a20dbc87')

sources_arm=("https://gitea.arsenm.dev/Arsen6331/lure/releases/download/v0.0.4/lure_0.0.4_linux_armv6.tar.gz")
checksums_arm=('1a7e0385b4663f4466f115ad961b609bde546f54f8874abef4efe2f804c2cfe3')

sources_386=("https://gitea.arsenm.dev/Arsen6331/lure/releases/download/v0.0.4/lure_0.0.4_linux_i386.tar.gz")
checksums_386=('5c16a65bd5680599c6dd9427fb4bdf98497e43a55cfe5f811861cd89421ec65a')

sources_amd64=("https://gitea.arsenm.dev/Arsen6331/lure/releases/download/v0.0.4/lure_0.0.4_linux_x86_64.tar.gz")
checksums_amd64=('26d7c1bb56361cf4e7193884676b674c9233173228969edf3dcca276bf924c89')

sources_riscv64=("https://gitea.arsenm.dev/Arsen6331/lure/releases/download/v0.0.4/lure_0.0.4_linux_riscv64.tar.gz")
checksums_riscv64=('33acf48060db24e1d46c6aae200398c40c174cd86cbf0f47d2d87c37296363a3')

package() {
	install -Dm755 "./lure" "${pkgdir}/usr/bin/lure"
}
