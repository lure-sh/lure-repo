name='lure-bin'
version=0.0.8
release=2
desc='Linux User REpository'
homepage='https://gitea.elara.ws/Elara6331/lure'
maintainer='Elara Musayelyan <elara@elara.ws>'
maintainer_ru='Элара Мусаелян <elara@elara.ws>'
architectures=('amd64' 'arm64' 'riscv64' 'arm6' '386')
license=('GPL-3.0-or-later')
provides=('lure')
conflicts=('lure' 'linux-user-repository' 'linux-user-repository-bin' 'linux-user-repository-git')

sources_arm64=("https://gitea.elara.ws/Elara6331/lure/releases/download/v0.0.8/lure_0.0.8_linux_aarch64.tar.gz")
checksums_arm64=('b368c7ad715bd9dac539d9f74f98b947ae7f4e124a31d8716f42661a1488042f')

sources_arm=("https://gitea.elara.ws/Elara6331/lure/releases/download/v0.0.8/lure_0.0.8_linux_armv6.tar.gz")
checksums_arm=('fde1102eded9368f92d2320ebe41df95463b59f7b19bfb1f304959dcbd17bc81')

sources_amd64=("https://gitea.elara.ws/Elara6331/lure/releases/download/v0.0.8/lure_0.0.8_linux_x86_64.tar.gz")
checksums_amd64=('4354efafe87be9365fbee0b7de74420ebed87db6ffa030e5f4be9e8ebbadd8cf')

sources_386=("https://gitea.elara.ws/Elara6331/lure/releases/download/v0.0.8/lure_0.0.8_linux_i386.tar.gz")
checksums_386=('de54752df82483ea0e86af678743822c4e4685d8a3e14eaf886366bfe3b30677')

sources_riscv64=("https://gitea.elara.ws/Elara6331/lure/releases/download/v0.0.8/lure_0.0.8_linux_riscv64.tar.gz")
checksums_riscv64=('e325669cf6524a1246ff1a2fbcaeecc5b1f3a600f00172d307a3de5974877f20')

package() {
	install-binary ./lure
}
