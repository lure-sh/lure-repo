name='lure-bin'
version=0.0.3
release=1
desc='Linux User REpository'
homepage='https://gitea.arsenm.dev/Arsen6331/lure'
architectures=('amd64' 'aarch64' 'arm7' 'arm6' '386' 'riscv64')
license=('GPL-3.0-or-later')
provides=('lure')
conflicts=('lure')

sources_arm64=("https://gitea.arsenm.dev/Arsen6331/lure/releases/download/v0.0.3/lure_0.0.3_linux_aarch64.tar.gz")
checksums_arm64=('6625ae76899b7cd27e202c81245399e02cd5d2c5e06de92da6e12670144a9890')

sources_arm=("https://gitea.arsenm.dev/Arsen6331/lure/releases/download/v0.0.3/lure_0.0.3_linux_armv6.tar.gz")
checksums_arm=('1a31a6256aea5babae0318a05934dd15620df8a4b2bb06998e4417031e470d91')

sources_386=("https://gitea.arsenm.dev/Arsen6331/lure/releases/download/v0.0.3/lure_0.0.3_linux_i386.tar.gz")
checksums_386=('869ba223fafedd53466f51fc0813d622d2ce35b6ceef7e9bb75e59619a19645e')

sources_amd64=("https://gitea.arsenm.dev/Arsen6331/lure/releases/download/v0.0.3/lure_0.0.3_linux_x86_64.tar.gz")
checksums_amd64=('e584f547c1a184b714033fad8ede28382a4bf5e16b063a29781344713cbd6e81')

sources_riscv64=("https://gitea.arsenm.dev/Arsen6331/lure/releases/download/v0.0.3/lure_0.0.3_linux_riscv64.tar.gz")
checksums_riscv64=('0f5601db74184e00995de286fd636e36be4323ba412e86f1440276d61e9abb42')

package() {
	install -Dm755 "./lure" "${pkgdir}/usr/bin/lure"
}
