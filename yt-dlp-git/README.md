# yt-dlp-git

A [LURE](https://github.com/lure-sh/lure) package for [yt-dlp](https://github.com/yt-dlp/yt-dlp), a feature-rich command-line audio/video downloader and youtube-dl fork with additional features and fixes.

## Package Information

| Field | Value |
|-------|-------|
| Upstream | https://github.com/yt-dlp/yt-dlp |
| License | Unlicense |
| Architecture | `all` (pure Python) |
| Provides | `yt-dlp` |
| Conflicts | `yt-dlp` |

Based on the [AUR yt-dlp-git package](https://aur.archlinux.org/packages/yt-dlp-git) by katt.

## Building

```bash
cd yt-dlp-git
lure build
```

## Installation

```bash
sudo apt install ./yt-dlp-git_*.deb
```

This will automatically remove any existing `yt-dlp` package from the distribution repositories due to the `conflicts` declaration.

## Verification

```bash
yt-dlp --version
```

## Dependencies

### Build Dependencies

- `git` — for cloning and version detection
- `make` — for running build targets
- `pandoc` — for generating man pages and documentation
- `python3-all` — Python interpreter
- `python3-build` — PEP 517 build frontend
- `python3-installer` — for installing wheels
- `python3-wheel` — wheel support
- `python3-pip` — for installing newer build dependencies

### Runtime Dependencies

- `python3`, `python3-certifi`, `python3-requests`, `python3-urllib3` — core requirements
- `python3-mutagen` — metadata handling
- `python3-pycryptodome` — AES-128 HLS stream decryption
- `python3-websockets` — websocket download support
- `python3-brotli` — brotli content encoding
- `ffmpeg` — video/audio post-processing (essential for merging formats)

## Lessons Learned

### 1. Ubuntu/Debian packages can be too old for bleeding-edge Python projects

**Problem:** yt-dlp's `pyproject.toml` requires `hatchling>=1.27.0`, but Ubuntu Noble (24.04) provides `python3-hatchling` version 1.21.0.

**Error message:**
```
ERROR Missing dependencies:
    hatchling>=1.27.0
```

**Solution:** Install newer build dependencies via pip during the build phase instead of relying on system packages:

```bash
build_deps=("..." "python3-pip")  # Add pip to build deps

build() {
    # Install newer hatchling that meets requirements
    python3 -m pip install --user --break-system-packages "hatchling>=1.27.0"
    ...
}
```

### 2. Trove classifiers must recognize new Python versions

**Problem:** After fixing hatchling, the build failed because `trove-classifiers` (2024.1.31) didn't recognize `Programming Language :: Python :: 3.14`.

**Error message:**
```
ValueError: Unknown classifier in field `project.classifiers`: Programming Language :: Python :: 3.14
```

**Solution:** Also install a newer `trove-classifiers` via pip:

```bash
python3 -m pip install --user --break-system-packages \
    "hatchling>=1.27.0" \
    "trove-classifiers>=2024.10.0"
```

### 3. The `--break-system-packages` flag is required on modern Debian/Ubuntu

PEP 668 introduced "externally managed environments" which prevents pip from modifying system Python packages by default. For build-time dependencies that won't persist after package installation, using `--break-system-packages` with `--user` is acceptable.

### 4. Package conflicts and provides work correctly

When `conflicts=("yt-dlp")` and `provides=("yt-dlp")` are declared:
- `apt` automatically removes the conflicting package during installation
- Reverse dependencies (like `hypnotix`) remain satisfied because the new package `provides` the same capability

### 5. Version function for git packages

The version function generates Debian-compatible versions from git tags:

```bash
version() {
    cd "$srcdir/yt-dlp"
    git describe --long --tags --abbrev=7 --exclude=nightly | \
        sed 's/\([^-]*-g\)/r\1/;s/-/./g'
}
```

This produces versions like `2025.12.08.r53.g27afb31` where:
- `2025.12.08` — latest tag
- `r53` — 53 commits since tag
- `g27afb31` — git commit hash

### 6. Architecture `all` for pure Python packages

Since yt-dlp is pure Python with no compiled extensions, using `architectures=("all")` produces a single `.deb` that works on any architecture (amd64, arm64, armhf, etc.).

## AUR Discussion Notes

From the [AUR comments](https://aur.archlinux.org/packages/yt-dlp-git) (as of 2025-11-15):

- The `yt-dlp-ejs` optional dependency provides non-deprecated YouTube support
- Version pinning between `yt-dlp` and `yt-dlp-ejs` is a known complexity
- The check function may need `--deselect` for websocket tests until python-websockets updates

## Optional Dependencies (not included by default)

For additional functionality, consider installing:

- `rtmpdump` — RTMP stream support
- `atomicparsley` — embedding thumbnails in m4a files
- `aria2` — external downloader support
- `phantomjs` — JavaScript-based extractors
- `python3-secretstorage` — browser cookie extraction (GNOME keyring)
- `python3-xattr` — xattr metadata support

## See Also

- [yt-dlp documentation](https://github.com/yt-dlp/yt-dlp#readme)
- [yt-dlp supported sites](https://github.com/yt-dlp/yt-dlp/blob/master/supportedsites.md)
- [LURE documentation](https://github.com/lure-sh/lure)
- [AUR yt-dlp-git](https://aur.archlinux.org/packages/yt-dlp-git)
