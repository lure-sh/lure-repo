name='linux-user-repository-bin'
version=0.0.9
release=1
desc='Linux User REpository'
homepage='https://lure.sh'
maintainer='Elara Musayelyan <elara@elara.ws>'
maintainer_ru='Элара Мусаелян <elara@elara.ws>'
architectures=('amd64' 'arm64' 'riscv64' 'arm6' '386')
license=('GPL-3.0-or-later')
provides=('linux-user-repository')
conflicts=('linux-user-repository' 'linux-user-repository-bin' 'linux-user-repository-git')

sources_arm64=("https://gitea.elara.ws/lure/lure/releases/download/v0.0.9/lure_0.0.9_linux_aarch64.tar.gz")
checksums_arm64=('b72bfe95f75340aa617e9fab09ef066dfa3a0c2042d14fd92219463b370e3f40')

sources_arm=("https://gitea.elara.ws/lure/lure/releases/download/v0.0.9/lure_0.0.9_linux_armv6.tar.gz")
checksums_arm=('7a90ea965a42f6ba23fcaf7206bdd721b36771833c67969c5be59793163bad0a')

sources_amd64=("https://gitea.elara.ws/Elara6331/lure/releases/download/v0.0.9/lure_0.0.9_linux_x86_64.tar.gz")
checksums_amd64=('23cb4ce8ec33aa9fc850fbc14988e1e0353085ab67c2ebdb7a4002b59cef26fd')

sources_386=("https://gitea.elara.ws/Elara6331/lure/releases/download/v0.0.9/lure_0.0.9_linux_i386.tar.gz")
checksums_386=('23866ea947cdb3aa01ec46f7349b82ac359843948161e007243ef8c435ba884e')

sources_riscv64=("https://gitea.elara.ws/Elara6331/lure/releases/download/v0.0.9/lure_0.0.9_linux_riscv64.tar.gz")
checksums_riscv64=('093e0d24a09feb6a56af7a18e6be64f1ef2a1b8cedc63bcc048f46b5c6dbf116')

package() {
	install-binary ./lure
}
