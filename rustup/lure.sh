name='rustup'
version='1.25.1'
release='1'
desc='Rust toolchain manager'
homepage='https://rustup.rs/'
maintainer='s e <iamawacko@protonmail.com>'
architectures=('amd64' 'aarch64' 'arm7' '386')
license=('MIT', 'Apache-2.0')
provides=('rustup')
conflicts=('rustup')

prepare_amd64() {
	wget https://static.rust-lang.org/rustup/dist/x86_64-unknown-linux-musl/rustup-init	
}

prepare_aarch64() {
	wget https://static.rust-lang.org/rustup/dist/aarch64-unknown-linux-musl/rustup-init	
}

prepare_arm7() {
	wget https://static.rust-lang.org/rustup/dist/armv7-unknown-linux-gnueabihf/rustup-init	
}

prepare_386() {
	wget https://static.rust-lang.org/rustup/dist/i686-unknown-linux-gnu/rustup-init	
}

package() {
	install -Dm755 "rustup-init" "${pkgdir}/usr/bin/rustup"
}
