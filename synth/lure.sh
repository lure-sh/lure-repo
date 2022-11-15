name='synth'
version='0.6.8'
release='2'
desc='The Open Source Data Generator'
homepage='https://getsynth.com/'
maintainer='s e <iamawacko@protonmail.com>'
architectures=('amd64' 'aarch64' 'arm7' 'arm6' '386')
license=('MIT', 'Apache-2.0')
sources=("https://github.com/shuttle-hq/synth/archive/refs/tags/v${version}.tar.gz")
checksums='18996ebb6a7a8a9d36d961fd7fc1dee38d78b0d03c57ab5681f312600ab5139e'
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
