name='synth'
version='0.6.9'
release='2'
desc='The Open Source Data Generator'
homepage='https://getsynth.com/'
maintainer='s e <iamawacko@protonmail.com>'
architectures=('amd64' 'arm64' 'arm7' 'arm6' '386')
license=('MIT' 'Apache-2.0')
sources=("https://github.com/shuttle-hq/synth/archive/refs/tags/v${version}.tar.gz")
checksums=('f89fc355dc0e311a6e5e0e8047f4721f23e35cdcb3355e85c7c66e8e2e67da91')
provides=('synth')
conflicts=('synth')

build_deps=('rustup' 'libsqlite3-dev')
build_deps_arch=('rustup' 'sqlite')
build_deps_opensuse=('rustup' 'sqlite3')
build_deps_alpine=('rustup' 'sqlite-dev')
build_deps_fedora=('rustup' 'libsq3-devel')

prepare() {
	rustup install nightly
	cd "${srcdir}/${name}-${version}"
	cargo fetch --locked
}

build() {
	cd "${srcdir}/${name}-${version}"
	cargo build --frozen --release
}

package() {
	cd "${srcdir}/${name}-${version}"
	install -Dm0755 "target/release/${name}" "${pkgdir}/usr/bin/${name}"
}
