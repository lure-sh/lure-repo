name='oniongen-rs'
version='0.6.3'
release='2'
desc='A v3 .onion address vanity URL generator written in Rust'
homepage='https://gitlab.com/iamawacko-oss/oniongen-rs'
maintainer='s e <iamawacko@protonmail.com>'
architectures=('amd64' 'arm64' 'arm7' 'arm6' '386')
license=('MIT')
sources=("https://static.crates.io/crates/${name}/${name}-${version}.crate")
checksums=('96ea9b8294e49b00a31f5ec5b127cc0b516d017f6a463e875d7c51855a09bd61')
provides=('oniongen-rs')
conflicts=('oniongen-rs')

build_deps=('rustup')

prepare() {
	rustup install stable
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
