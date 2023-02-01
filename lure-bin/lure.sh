name='lure-bin'
version=0.0.7
release=1
desc='Linux User REpository'
homepage='https://gitea.arsenm.dev/Arsen6331/lure'
architectures=('amd64' 'arm64' 'riscv64' 'arm6' '386')
license=('GPL-3.0-or-later')
provides=('lure')
conflicts=('lure')

sources_arm64=("https://gitea.arsenm.dev/Arsen6331/lure/releases/download/v0.0.7/lure_0.0.7_linux_aarch64.tar.gz")
checksums_arm64=('d86273bf14e80c94b80f6d553c3e7e36871b3dcac3cad337d3a123250fdc18dd')

sources_arm=("https://gitea.arsenm.dev/Arsen6331/lure/releases/download/v0.0.7/lure_0.0.7_linux_armv6.tar.gz")
checksums_arm=('c9ebb8616b6880cd53f2e2c12ea8945ee8fb070a3e0c49dc2d5d893be052382c')

sources_amd64=("https://gitea.arsenm.dev/Arsen6331/lure/releases/download/v0.0.7/lure_0.0.7_linux_x86_64.tar.gz")
checksums_amd64=('693d113d8ec408ffa2f0b7a35708e072bb0cc69254d681928fdef2b9d07bc7fb')

sources_386=("https://gitea.arsenm.dev/Arsen6331/lure/releases/download/v0.0.7/lure_0.0.7_linux_i386.tar.gz")
checksums_386=('464ffabadc9a406f79eb0d1f634fea7803e10fde6a47610bc90945c4bb0029c1')

sources_riscv64=("https://gitea.arsenm.dev/Arsen6331/lure/releases/download/v0.0.7/lure_0.0.7_linux_riscv64.tar.gz")
checksums_riscv64=('6e2eef3937f403bef1a8890bca4ce13daad39168a7887a75abf68e560b660c30')
r
package() {
	install-binary ./lure
}
