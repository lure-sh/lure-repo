name='lure-bin'
version=%s
release=1
desc='Linux User REpository'
homepage='https://gitea.elara.ws/Elara6331/lure'
maintainer='Elara Musayelyan <elara@elara.ws>'
maintainer_ru='Элара Мусаелян <elara@elara.ws>'
architectures=('amd64' 'arm64' 'riscv64' 'arm6' '386')
license=('GPL-3.0-or-later')
provides=('lure')
conflicts=('lure' 'linux-user-repository' 'linux-user-repository-bin' 'linux-user-repository-git')

sources_arm64=("%s")
checksums_arm64=('%s')

sources_arm=("%s")
checksums_arm=('%s')

sources_amd64=("%s")
checksums_amd64=('%s')

sources_386=("%s")
checksums_386=('%s')

sources_riscv64=("%s")
checksums_riscv64=('%s')

package() {
	install-binary ./lure
}
