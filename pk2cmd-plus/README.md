# pk2cmd-plus for LURE

A [LURE](https://lure.sh/) package for **pk2cmd-plus** — the PICkit 2 command-line interface with updated device file support.

## What is pk2cmd-plus?

`pk2cmd` is Microchip's command-line tool for programming PIC microcontrollers using the PICkit 2 programmer. The "plus" variant bundles an updated device file (`PK2DeviceFile.dat`) that supports newer PIC devices beyond what the original Microchip release included.

This package provides:
- **pk2cmd v1.21 RC1** — The last release candidate from Microchip
- **Device File v2.63.218** — Extended device support from the community
- **udev rules** — Allows non-root USB access to PICkit 2 hardware

## Installation

```bash
# Build the package
lure build

# Install
sudo apt install ./pk2cmd-plus_1.21~rc1+1.63.148-2_amd64.deb

# Reload udev rules
sudo udevadm control --reload-rules
sudo udevadm trigger
```

## Usage

```bash
# Check version and device file
pk2cmd -?V

# Auto-detect connected PIC
pk2cmd -P

# Program a hex file
pk2cmd -PPIC16F887 -M -F firmware.hex

# Erase device
pk2cmd -PPIC16F887 -E
```

## Credits

### Original AUR Package
- **Package**: [pk2cmd-plus](https://aur.archlinux.org/packages/pk2cmd-plus) on AUR
- **Maintainer**: BxS (bxsbxs at gmail dot com)


### Source Code Mirrors
- [psmay/pk2cmd](https://github.com/psmay/pk2cmd) — GitHub mirror of Microchip's v1.21 RC1 source
- [martonmiklos/pk2cmd](https://github.com/martonmiklos/pk2cmd) — Fork with updated device files and PICkit 3 support

### Original Software
- **Microchip Technology Inc.** — Original pk2cmd software (discontinued)

## Lessons Learned

This section documents issues encountered while porting the AUR PKGBUILD to LURE, to help future packagers avoid the same pitfalls.

### 1. LURE ZIP Extraction Bug

**Problem**: LURE's archive handler fails on ZIP files with nested directory structures (e.g., `pk2cmd/pk2cmd/`).

```
Error building package error="handling file 61: pk2cmd/: mkdir .../pk2cmd: file exists"
```

**Solution**: Use `git+` source prefix instead of ZIP URLs:
```bash
sources=("git+https://github.com/psmay/pk2cmd.git")
```

### 2. Dead Microchip URLs

**Problem**: Original Microchip download URLs return 403/400 errors (as of 2023+).

**Solution**: Use GitHub mirrors or Web Archive. The `git+` approach also sidesteps this issue entirely.

### 3. LURE Source Naming Syntax

**Problem**: The `filename::URL` syntax fails with certain characters:
```
Error: parse "pk2_devicefile_osfile_paths.patch::https://...": first path segment in URL cannot contain colon
```

**Solution**: Omit the filename prefix; let LURE derive filenames from the URL's last path segment.

### 4. Patch Line Ending Mismatch

**Problem**: AUR patches expect Windows CRLF line endings, but GitHub sources have Unix LF:
```
Hunk #1 FAILED at 84 (different line endings).
```

**Solution**: Replace patch files with equivalent `sed` commands:
```bash
sed -i 's/\r$//' cmd_app.cpp  # Convert CRLF to LF first
sed -i 's|old_pattern|new_pattern|g' cmd_app.cpp
```

### 5. Debian Version Number Restrictions

**Problem**: dpkg rejects underscores in version strings:
```
'Version' field value '1.21rc1_1.63.148-2': invalid character in version number
```

**Solution**: Use Debian-compliant version format:
- `~` for pre-release indicators (sorts before release)
- `+` for additional metadata
- Example: `1.21~rc1+1.63.148`

### 6. Device File Path Substitution

**Problem**: The source code doesn't use a `#define` for the device file path. The original patch targets a specific code pattern.

**Solution**: Match the exact source pattern with `sed`:
```bash
sed -i 's|_tcsncpy_s(tempString, "PK2DeviceFile.dat", 17)|_tcsncpy_s(tempString, "/usr/share/pk2/PK2DeviceFile.dat", 33)|g' cmd_app.cpp
```

## License

pk2cmd is distributed under Microchip's proprietary license. See the [LICENSE](https://aur.archlinux.org/cgit/aur.git/plain/LICENSE?h=pk2cmd-plus) file for terms.

This LURE packaging script is provided as-is for convenience.

## See Also

- [PICkit 2 User's Guide](https://www.microchip.com/en-us/development-tool/pg164120)
- [pk2cmd-minus](https://github.com/cjacker/pk2cmd-minus) — Enhanced fork with PICkit 3 support
- [LURE Documentation](https://github.com/lure-sh/lure/tree/master/docs)
