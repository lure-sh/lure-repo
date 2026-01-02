name="harper-git"
version="1526.8578e2b"
release="1"
desc="The Grammar Checker for Developers"
homepage="https://github.com/elijah-potter/harper"
maintainer="Daniel Fichtinger <daniel@ficd.ca>"
architectures=("amd64")
license=("Apache-2.0")
provides=("harper")
conflicts=("harper")

build_deps=("git" "curl" "ca-certificates")

# Runtime dependencies
deps=("libc6" "libgcc-s1")
deps_arch=("glibc" "gcc-libs")

sources=("git+https://github.com/elijah-potter/harper.git")
checksums=("SKIP")

# 1. New Helper: Restores environment variables if a local toolchain is found
setup_env() {
	if [ -d "$srcdir/.cargo" ]; then
		export RUSTUP_HOME="$srcdir/.rustup"
		export CARGO_HOME="$srcdir/.cargo"
		export PATH="$CARGO_HOME/bin:$PATH"
	fi
}

setup_rust() {
	local MIN_VER="1.85.0"

	# Check system rust
	if command -v rustc &>/dev/null; then
		local CURRENT_VER=$(rustc --version | awk '{print $2}')
		if [ "$(printf '%s\n' "$MIN_VER" "$CURRENT_VER" | sort -V | head -n1)" = "$MIN_VER" ]; then
			echo "System Rust version $CURRENT_VER is sufficient."
			return 0
		fi
		echo "System Rust version $CURRENT_VER is too old (need $MIN_VER+)."
	fi

	# Bootstrap if needed
	echo "Bootstrapping local Rust toolchain..."
	mkdir -p "$srcdir/.rustup" "$srcdir/.cargo"

	# Apply envs immediately for the installation
	setup_env

	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs |
		sh -s -- -y --no-modify-path --default-toolchain stable --profile minimal

	echo "Local Rust toolchain installed: $(rustc --version)"
}

version() {
	cd "$srcdir/harper"
	printf "%s.%s" "$(git rev-list --count HEAD)" "$(git rev-parse --short HEAD)"
}

prepare() {
	# 2. Run setup_rust (which installs if needed)
	setup_rust

	cd "$srcdir/harper"
	cargo fetch --locked --target "$(rustc -vV | sed -n 's/host: //p')"
}

build() {
	# 3. Restore the environment variables so cargo looks in the right place
	setup_env

	cd "$srcdir/harper"
	cargo build --frozen --release --bin harper-cli --bin harper-ls
}

package() {
	# 4. Restore envs (optional here, but good practice)
	setup_env

	cd "$srcdir/harper"
	install -Dm 755 -t "${pkgdir}/usr/bin" \
		target/release/harper-cli \
		target/release/harper-ls
}
