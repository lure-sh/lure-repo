# fdbox-git LURE Package

## What is fdbox?

[fdbox](https://github.com/diegoiast/fdbox) is a FreeDOS-like shell and utilities for Linux. It provides a command-line environment that mimics the classic DOS experience, implementing familiar commands like `dir`, `cd`, `type`, `copy`, `del`, and more.

Think of it as a nostalgic bridge for those who grew up with DOS, or an educational tool for understanding how command-line interfaces evolved.

### Features

- FreeDOS-compatible command syntax
- Built-in commands: `dir`, `cd`, `cls`, `copy`, `move`, `del`, `mkdir`, `type`, `echo`, `set`, `date`, `time`, `ver`, `exit`, etc. Run `fdbox help` for the full list.
- Run a single command with `fdbox <command> [args]`, or start the interactive shell with `fdbox`
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

**Correct:** use LURE's `git-version` helper, as the [package conventions](https://github.com/lure-sh/lure/blob/master/docs/packages/conventions.md#git-packages) require for `-git` packages:
```bash
version() {
    cd "$srcdir/fdbox"
    git-version
}
```

**Result:** `282.6acbada` — revision count, then short hash. It starts with a digit, so Debian accepts it, and it uses LURE's embedded Git, so users don't need Git installed to compute it. Don't add an `r` or a `0.0.0.` prefix: the convention omits the `r` precisely because some package managers reject versions that don't start with a digit.

### 2. Projects Without an `install` Target

**Problem:** fdbox's CMakeLists.txt defines no `install()` rules, so `make install` always fails with `No rule to make target 'install'`.

**Solution:** install the binary directly with LURE's `install-binary` helper, which places it in `/usr/bin` with mode 755:
```bash
package() {
    install-binary "$srcdir/fdbox/build/fdbox"
}
```

Avoid `make install || install ...`: when the target never exists, the first command only adds an error to every build log.

### 3. CMake in `prepare()` vs `build()`

**Why CMake runs in `prepare()`:** The CMake configure step downloads dependencies via CPM (CMake Package Manager), which needs Git and internet access. Keeping configuration in `prepare()` and compilation in `build()` separates the network step from the compile step. `build()` builds only the `fdbox` target, skipping upstream's `tests` executable.

Python is not a build dependency: Format.cmake only uses it for optional clang-format targets and adds dummy targets when it is missing.

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
| `123.abc1234` | ✅ Yes | LURE `-git` convention (`git-version`) |
| `1.0.0` | ✅ Yes | Standard semver |
| `2024.01.15` | ✅ Yes | Date-based |
| `0~git20260109` | ✅ Yes | Pre-release with tilde |

## File Structure

```
fdbox-git/
├── lure.sh          # LURE build script
└── README.md        # This file
```

`lure build` writes the generated `.deb` to the current directory; don't commit it.

## References

- [fdbox GitHub Repository](https://github.com/diegoiast/fdbox)
- [LURE Documentation](https://lure.sh/)
- [Debian Policy: Version Format](https://www.debian.org/doc/debian-policy/ch-controlfields.html#version)
