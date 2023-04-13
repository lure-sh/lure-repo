name='rustup'
version='1.25.1'
release='1'
desc='Rust toolchain manager'
homepage='https://rustup.rs/'
maintainer='s e <iamawacko@protonmail.com>'
architectures=('amd64' 'arm64' 'arm7' '386')
license=('MIT' 'Apache-2.0')
provides=('rustup')
conflicts=('rustup')

sources_amd64=('https://static.rust-lang.org/rustup/dist/x86_64-unknown-linux-musl/rustup-init')
checksums_amd64=('95427cb0592e32ed39c8bd522fe2a40a746ba07afb8149f91e936cddb4d6eeac')

sources_arm64=('https://static.rust-lang.org/rustup/dist/aarch64-unknown-linux-musl/rustup-init')
checksums_arm64=('7855404cdc50c20040c743800c947b6f452490d47f8590a4a83bc6f75d1d8eda')

sources_arm7=('https://static.rust-lang.org/rustup/dist/armv7-unknown-linux-gnueabihf/rustup-init')
checksums_arm7=('48c5ecfd1409da93164af20cf4ac2c6f00688b15eb6ba65047f654060c844d85')

sources_386=('https://static.rust-lang.org/rustup/dist/i686-unknown-linux-gnu/rustup-init')
checksums_386=('0e0be29c560ad958ba52fcf06b3ea04435cb3cd674fbe11ce7d954093b9504fd')

package() {
	install -Dm755 "rustup-init" "${pkgdir}/usr/bin/rustup"
}
