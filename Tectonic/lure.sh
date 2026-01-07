name="tectonic-git"
version="0.0.0" # Will be updated dynamically
release="1"
desc="Modernized, complete, self-contained TeX/LaTeX engine"
homepage="https://tectonic-typesetting.github.io/"
maintainer="éclairevoyant"
architectures=("amd64")
license=("MIT")
provides=("tectonic")
conflicts=("tectonic")

# Build Dependencies (Debian/Ubuntu/Mint names)
# We need development headers for C libraries
build_deps=("git" "pkg-config" "build-essential" "libfontconfig1-dev" "libharfbuzz-dev" "libicu-dev" "libssl-dev" "curl" "ca-certificates")

# Runtime Dependencies
deps=("libfontconfig1" "libharfbuzz-icu0" "libssl3")

# Arch Linux Overrides (kept for reference/cross-compatibility)
build_deps_arch=("rust" "gcc" "pkg-config" "git" "fontconfig" "harfbuzz-icu" "openssl")
deps_arch=("fontconfig" "harfbuzz-icu" "openssl")

sources=(
    "git+https://github.com/tectonic-typesetting/tectonic.git"
    "git+https://github.com/tectonic-typesetting/tectonic-staging.git"
)
checksums=("SKIP" "SKIP")

# --- Rust Bootstrap Logic ---
setup_env() {
    if [ -d "$srcdir/.cargo" ]; then
        export RUSTUP_HOME="$srcdir/.rustup"
        export CARGO_HOME="$srcdir/.cargo"
        export PATH="$CARGO_HOME/bin:$PATH"
    fi
}

setup_rust() {
    local MIN_VER="1.80.0" # Tectonic needs recent Rust
    
    if command -v rustc &> /dev/null; then
        local CURRENT_VER=$(rustc --version | awk '{print $2}')
        if [ "$(printf '%s\n' "$MIN_VER" "$CURRENT_VER" | sort -V | head -n1)" = "$MIN_VER" ]; then
            echo "System Rust version $CURRENT_VER is sufficient."
            return 0
        fi
        echo "System Rust version $CURRENT_VER is too old (need $MIN_VER+)."
    fi

    echo "Bootstrapping local Rust toolchain..."
    mkdir -p "$srcdir/.rustup" "$srcdir/.cargo"
    setup_env

    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | \
        sh -s -- -y --no-modify-path --default-toolchain stable --profile minimal
}
# ----------------------------

version() {
    cd "$srcdir/tectonic"
    # Matches PKGBUILD logic to generate version string
    git describe --tags | sed 's/^cfg_support-v//;s/\([^-]*-\)g/r\1/;s/-/./g'
}

prepare() {
    setup_rust
    
    cd "$srcdir/tectonic"
    
    # Link the staging repo from LURE's srcdir to the submodule path
    git submodule init reference_sources
    git submodule set-url reference_sources "$srcdir/tectonic-staging"
    git submodule update reference_sources
    
    # Fetch Rust dependencies
    cargo fetch --locked --target "$(rustc -vV | sed -n 's/host: //p')"
}

build() {
    setup_env
    cd "$srcdir/tectonic"
    # Build with external harfbuzz (system libs) as requested in PKGBUILD
    cargo build --frozen --release --features external-harfbuzz
}

package() {
    setup_env
    cd "$srcdir/tectonic"
    install -Dm755 target/release/tectonic -t "$pkgdir/usr/bin/"
    install -Dm644 LICENSE -t "$pkgdir/usr/share/licenses/$name/"
}
