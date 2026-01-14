# fdbox-git LURE Package

## What is fdbox?

[fdbox](https://github.com/diegoiast/fdbox) is a FreeDOS-like shell and utilities for Linux. It provides a command-line environment that mimics the classic DOS experience, implementing familiar commands like `dir`, `cd`, `type`, `copy`, `del`, and more.

Think of it as a nostalgic bridge for those who grew up with DOS, or an educational tool for understanding how command-line interfaces evolved.

### Features

- FreeDOS-compatible command syntax
- Built-in commands: `dir`, `cd`, `cls`, `copy`, `del`, `echo`, `exit`, `md`, `rd`, `type`, `ver`, etc.
- Some Unix utilities: `cal`, `head`, `tail`, `hexdump`
- Lightweight C implementation
- Cross-platform (Linux, Windows)

## Building Manually

```bash
sudo apt install build-essential cmake git
git clone https://github.com/diegoiast/fdbox.git
cd fdbox
mkdir build && cd build
cmake .. -DCMAKE_BUILD_TYPE=Release
make
./fdbox
```

## Lessons Learned: LURE Packaging Pitfalls

### 1. Debian Version Numbers Must Start with a Digit

**Problem:**
```
'Version' field value 'r282.6acbada-1': version number does not start with digit
```

**Cause:** The `version()` function generated `r282.6acbada` (commit count + short hash), but Debian policy requires version strings to begin with a digit.

**Wrong:**
```bash
version() {
    cd "$srcdir/fdbox"
    printf "r%s.%s" "$(git rev-list --count HEAD)" "$(git rev-parse --short HEAD)"
}
```

**Correct:**
```bash
version() {
    cd "$srcdir/fdbox"
    # Prefix with 0.0.0 to satisfy Debian's digit-first requirement
    printf "0.0.0.r%s.%s" "$(git rev-list --count HEAD)" "$(git rev-parse --short HEAD)"
}
```

**Result:** `0.0.0.r282.6acbada` — starts with a digit, Debian-compliant.

### 2. Fallback Installation When No `make install` Target Exists

**Problem:** Many small projects don't define an `install` target in their CMakeLists.txt.

**Solution:** Use `||` to fall back to manual installation:
```bash
package() {
    cd "$srcdir/fdbox/build"
    make DESTDIR="$pkgdir" install || install -Dm755 fdbox "$pkgdir/usr/bin/fdbox"
}
```

This tries `make install` first, and if it fails, manually installs the binary with correct permissions (755) to `/usr/bin/`.

### 3. CMake in `prepare()` vs `build()`

**Why CMake runs in `prepare()`:** The CMake configure step downloads dependencies via CPM (CMake Package Manager) and requires internet access. LURE's `prepare()` phase is designed for tasks requiring network access, while `build()` should work offline.

### 4. Git Source Syntax

For git repositories in LURE, use the `git+` prefix:
```bash
sources=("git+https://github.com/diegoiast/fdbox.git")
checksums=("SKIP")  # Git sources use SKIP for checksum
```

## Quick Reference: Debian Version Formats

| Format | Valid? | Example |
|--------|--------|---------|
| `r123.abc1234` | ❌ No | Starts with letter |
| `0.0.0.r123.abc1234` | ✅ Yes | Starts with digit |
| `1.0.0` | ✅ Yes | Standard semver |
| `2024.01.15` | ✅ Yes | Date-based |
| `0~git20260109` | ✅ Yes | Pre-release with tilde |

## File Structure

```
fdbox-git/
├── lure.sh          # LURE build script
├── README.md        # This file
└── *.deb            # Generated package (after build)
```

## References

- [fdbox GitHub Repository](https://github.com/diegoiast/fdbox)
- [LURE Documentation](https://lure.sh/)
- [Debian Policy: Version Format](https://www.debian.org/doc/debian-policy/ch-controlfields.html#version)
