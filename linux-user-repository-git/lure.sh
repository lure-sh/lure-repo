name='linux-user-repository-git'
version='333.0c6cdad'
release=1
desc='Linux User REpository'
homepage='https://lure.sh'
maintainer='Elara Musayelyan <elara@elara.ws>'
maintainer_ru='Элара Мусаелян <elara@elara.ws>'
architectures=('amd64' 'arm64' 'arm7' 'arm6' '386' 'riscv64')
license=('GPL-3.0-or-later')
provides=('linux-user-repository')
conflicts=('linux-user-repository' 'linux-user-repository-bin' 'linux-user-repository-git')

build_deps=('golang')
build_deps_arch=('go')
build_deps_alpine=('go')
build_deps_opensuse=('go')

sources=("git+https://gitea.elara.ws/lure/lure.git")
checksums=('SKIP')

version() {
	cd "$srcdir/lure"
	git-version
}

build() {
	cd "$srcdir/lure"
	CGO_ENABLED=0 go build -ldflags="-X 'go.elara.ws/lure/internal/config.Version=$version'"
}

package() {
	cd "$srcdir/lure"
	install-binary lure
	install-completion bash lure < scripts/completion/bash
	install-completion zsh lure < scripts/completion/zsh 
}
