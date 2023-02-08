name='lure-bin'
version=0.0.7
release=2
desc='Linux User REpository'
homepage='https://gitea.arsenm.dev/Arsen6331/lure'
architectures=('amd64' 'arm64' 'riscv64' 'arm6' '386')
license=('GPL-3.0-or-later')
provides=('lure')
conflicts=('lure')

sources_arm64=("https://gitea.arsenm.dev/Arsen6331/lure/releases/download/v0.0.7/lure_0.0.7_linux_aarch64.tar.gz")
checksums_arm64=('0808daf8d6f373642eabfa64375f8a69cb519c5d1c8208642a438eaca4c84b7a')

sources_arm=("https://gitea.arsenm.dev/Arsen6331/lure/releases/download/v0.0.7/lure_0.0.7_linux_armv6.tar.gz")
checksums_arm=('b7b6a50e72658c671dbb7803445692939d6ef924d86687d461546d2836395418')

sources_amd64=("https://gitea.arsenm.dev/Arsen6331/lure/releases/download/v0.0.7/lure_0.0.7_linux_x86_64.tar.gz")
checksums_amd64=('b7723a18ae54c5fbf7c052e6b03fbe68bda5fbb9a0b0b668ef4ac74204788bfe')

sources_386=("https://gitea.arsenm.dev/Arsen6331/lure/releases/download/v0.0.7/lure_0.0.7_linux_i386.tar.gz")
checksums_386=('ea04d08dc4aa89bc97bfb6e65c6dad670853bf4d351f3f1619ef868cbad427c0')

sources_riscv64=("https://gitea.arsenm.dev/Arsen6331/lure/releases/download/v0.0.7/lure_0.0.7_linux_riscv64.tar.gz")
checksums_riscv64=('12c893256ba803b7bf9885d00441aedd0758495ccf2b8158a57d5b3a93cf6981')

package() {
	install-binary ./lure
}
