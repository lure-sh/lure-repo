name='lure-bin'
version=0.0.6
release=1
desc='Linux User REpository'
homepage='https://gitea.arsenm.dev/Arsen6331/lure'
architectures=('amd64' 'arm64' 'riscv64' 'arm6' '386')
license=('GPL-3.0-or-later')
provides=('lure')
conflicts=('lure')

sources_arm64=("https://gitea.arsenm.dev/Arsen6331/lure/releases/download/v0.0.6/lure_0.0.6_linux_aarch64.tar.gz")
checksums_arm64=('f554efe358089da9a3e2665c725af98cc5a13366ccca6a6c37f67a28fe93ce06')

sources_arm=("https://gitea.arsenm.dev/Arsen6331/lure/releases/download/v0.0.6/lure_0.0.6_linux_armv6.tar.gz")
checksums_arm=('2a67325bb69c6e236738d4471752be4457d2ae0a3fcd9da0477545d08e13365c')

sources_amd64=("https://gitea.arsenm.dev/Arsen6331/lure/releases/download/v0.0.6/lure_0.0.6_linux_x86_64.tar.gz")
checksums_amd64=('3cf95577710d283ad2bce03f0a41ee51012ae482f24387104760852e27c4fbf8')

sources_386=("https://gitea.arsenm.dev/Arsen6331/lure/releases/download/v0.0.6/lure_0.0.6_linux_i386.tar.gz")
checksums_386=('126d1fa7f06b51e77b32e473b91d9647c8f5983dcb4d00d75a4206c29d355214')

sources_riscv64=("https://gitea.arsenm.dev/Arsen6331/lure/releases/download/v0.0.6/lure_0.0.6_linux_riscv64.tar.gz")
checksums_riscv64=('7269ae52e656a3c80a17405919daaabe1b4644cdf986acbdea671281ae1816c5')

package() {
	install-binary ./lure
}
