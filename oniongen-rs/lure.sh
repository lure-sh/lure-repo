name='oniongen-rs'
version='0.6.3'
release='1'
desc='A v3 .onion address vanity URL generator written in Rust'
homepage='https://gitlab.com/iamawacko-oss/oniongen-rs'
maintainer='s e <iamawacko@protonmail.com>'
architectures=('amd64' 'aarch64' 'arm7' 'arm6' '386')
license=('MIT')
sources=("https://gitlab.com/iamawacko-oss/oniongen-rs/-/archive/v${version}/oniongen-rs-v${version}.tar.gz")
checksums='SKIP'
provides=('oniongen-rs')
conflicts=('oniongen-rs')

build_deps=('wget') 
build_deps_arch=('rustup')
build_deps_opensuse=('rustup')
build_deps_alpine=('rustup')

prepare_arch() {
	rustup install stable
	cd "${srcdir}/${name}-${version}"
	cargo fetch --locked
}

prepare_opensuse() {
	rustup install stable
	cd "${srcdir}/${name}-${version}"
	cargo fetch --locked
}

prepare_alpine() {
	rustup install stable
	cd "${srcdir}/${name}-${version}"
	cargo fetch --locked
}

prepare() {
	rustup --version || wget https://sh.rustup.rs -O rustup.sh && sh rustup.sh -y 
}

build() {
	cd "${srcdir}/${name}-${version}"
	cargo build --frozen --release
}

package() {
	cd "${srcdir}/${name}-${version}"
	install -Dm0755 "target/release/${name}" "${pkgdir}/usr/bin/${name}"
}
