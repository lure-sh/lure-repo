name='linux-user-repository-bin'
version=0.1.0
release=1
desc='Linux User REpository'
homepage='https://lure.sh'
maintainer='Elara Musayelyan <elara@elara.ws>'
maintainer_ru='Элара Мусаелян <elara@elara.ws>'
architectures=('amd64' 'arm64' 'riscv64' 'arm6' '386')
license=('GPL-3.0-or-later')
provides=('linux-user-repository')
conflicts=('linux-user-repository' 'linux-user-repository-bin' 'linux-user-repository-git')

sources_arm64=("https://gitea.elara.ws/lure/lure/releases/download/v0.1.1/lure-0.1.1-linux-aarch64.tar.gz")
checksums_arm64=('3afb8436fb74cb5adb053d2121617817d96163eda8178c899c4953cf4f03b1bb')

sources_arm=("https://gitea.elara.ws/lure/lure/releases/download/v0.1.1/lure-0.1.1-linux-arm.tar.gz")
checksums_arm=('2f5de876a9e5113d6422b0baac3cc7d5e230917e4c3fcd4fdd6f03da0089faf6')

sources_amd64=("https://gitea.elara.ws/lure/lure/releases/download/v0.1.1/lure-0.1.1-linux-x86_64.tar.gz")
checksums_amd64=('9a1d819cb777ee189d79b6446e01be85931b8034743a23d3cdea6bd35f5b3a2a')

sources_386=("https://gitea.elara.ws/lure/lure/releases/download/v0.1.1/lure-0.1.1-linux-i386.tar.gz")
checksums_386=('a372d23dfd38534630783f5e570e2c5b365615f1d05a1b6b56b5ab2539316010')

sources_riscv64=("https://gitea.elara.ws/Elara6331/lure/releases/download/v0.1.1/lure-0.1.1-linux-riscv64.tar.gz")
checksums_riscv64=('869d728ea7284505331362aa7684a8f9070a7f28d4d27ccad8cb7de92efd060f')

package() {
	install-binary ./lure
	
	install-completion bash lure <"$srcdir/scripts/completion/bash"
	install-completion zsh lure <"$srcdir/scripts/completion/zsh"
}
