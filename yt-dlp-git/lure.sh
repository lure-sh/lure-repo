name="yt-dlp-git"
version="0.0.0"
release="1"
desc="A feature-rich command-line audio/video downloader"
homepage="https://github.com/yt-dlp/yt-dlp"
maintainer="Your Name <email@example.com>"
architectures=("all")
license=("Unlicense")
provides=("yt-dlp")
conflicts=("yt-dlp")

# Build Dependencies (Debian/Ubuntu names)
# NOTE: We exclude python3-hatchling because Ubuntu's version is too old
# We'll install hatchling via pip during build instead
build_deps=("git" "make" "pandoc" "python3-all" "python3-build" "python3-installer" "python3-wheel" "python3-pip")

# Runtime Dependencies
deps=("python3" "python3-certifi" "python3-requests" "python3-urllib3" "python3-mutagen" "python3-pycryptodome" "python3-websockets" "python3-brotli" "ffmpeg")

sources=("git+https://github.com/yt-dlp/yt-dlp.git")
checksums=("SKIP")

version() {
    cd "$srcdir/yt-dlp"
    git describe --long --tags --abbrev=7 --exclude=nightly | sed 's/\([^-]*-g\)/r\1/;s/-/./g'
}

prepare() {
    cd "$srcdir/yt-dlp"
    git clean -dfx
}

build() {
    cd "$srcdir/yt-dlp"
    
    # Install hatchling>=1.27.0 (Ubuntu's version is too old)
    python3 -m pip install --user --break-system-packages "hatchling>=1.27.0" "trove-classifiers>=2024.10.0"
    
    # Ensure ~/.local/bin is in PATH for hatchling
    export PATH="$HOME/.local/bin:$PATH"
    
    make pypi-files
    python3 devscripts/make_lazy_extractors.py
    python3 -m build --wheel --no-isolation
}

package() {
    cd "$srcdir/yt-dlp"
    python3 -m installer --destdir="$pkgdir" dist/*.whl
}
