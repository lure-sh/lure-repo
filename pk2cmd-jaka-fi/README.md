# pk2cmd-jaka-fi for LURE

A [LURE](https://lure.sh/) package for **pk2cmd** from [jaka-fi](https://github.com/jaka-fi/pk2cmd) — an enhanced PICkit 2/3/PKOB command-line programmer with extended device support.

## What is pk2cmd-jaka-fi?

This is a significantly enhanced fork of Microchip's original pk2cmd tool, maintained by jaka-fi. Key improvements over the original:

- **1588+ supported devices** (vs ~639 in the last official Microchip release)
- **PICkit 3 and PKOB support** (not just PICkit 2)
- **Modern libusb-1.0** (faster than legacy libusb-0.1)
- **MSB1st family support** (PIC16/PIC18 newer devices)
- **Optimized programming scripts** for faster write/verify
- **Active maintenance** with bug fixes and new device additions

## Installation

```bash
# Build the package
lure build

# Install
sudo apt install ./pk2cmd-jaka-fi_1.26.06-1_amd64.deb

# Reload udev rules
sudo udevadm control --reload-rules
sudo udevadm trigger
```

## Usage

The command is `pk3cmd` (to avoid conflicts with pk2cmd-plus):

```bash
# Check version and device file
pk3cmd -?V

# Auto-detect connected PIC
pk3cmd -P

# List all supported devices
pk3cmd -?P

# Program a hex file
pk3cmd -PPIC16F887 -M -F firmware.hex

# Erase device
pk3cmd -PPIC16F887 -E

# Power target from PICkit and release from reset
pk3cmd -PPIC16F887 -T -A5 -R
```

## Supported Hardware

- **PICkit 2** — Original and clones
- **PICkit 3** — Requires scripting firmware (see notes below)
- **PKOB** — PICkit On Board (found on some dev boards)

### PICkit 3 Notes

PICkit 3 requires special "scripting" firmware. If your PICkit 3 shows as not found:
1. Connect it to a Windows PC with MPLAB IPE
2. Let MPLAB update the firmware
3. Use this tool's scripting firmware mode

To revert PICkit 3 for use with MPLAB again, the firmware must be reset.

## Credits

### Upstream Project
- **Repository**: [jaka-fi/pk2cmd](https://github.com/jaka-fi/pk2cmd)
- **Maintainer**: jaka-fi

### Contributors (from upstream)
- **Microchip Technology Inc.** — Original pk2cmd software
- **Miklós Márton** — PICkit 3 support ([martonmiklos/pk2cmd](https://github.com/martonmiklos/pk2cmd))
- **Anobium / PICkitPlus team** — Extended device file (969→1588 devices)
- **dougy83** — Device file editor
- **bequest333** — MSB1st chip support
- **boborjan2** — libusb-1.0 support

### LURE Package
- **Packager**: Foad S. Farimani

## Comparison with pk2cmd-plus

| Feature | pk2cmd-plus | pk2cmd-jaka-fi |
|---------|-------------|----------------|
| Command | `pk2cmd` | `pk3cmd` |
| Devices | ~700 | 1588+ |
| PICkit 3 | ❌ | ✅ |
| PKOB | ❌ | ✅ |
| libusb | 0.1 (legacy) | 1.0 (modern) |
| Source | psmay/pk2cmd | jaka-fi/pk2cmd |

**Recommendation**: Use pk2cmd-jaka-fi unless you specifically need the older pk2cmd-plus for compatibility reasons.

## Lessons Learned

### Device File Path Patch Required

Same as pk2cmd-plus, the source code defaults to searching the current directory for `PK2DeviceFile.dat`. The `prepare()` function patches this to `/usr/share/pk2/`:

```bash
sed -i 's|_tcsncpy_s(tempString, "PK2DeviceFile.dat", 17)|_tcsncpy_s(tempString, "/usr/share/pk2/PK2DeviceFile.dat", 33)|g' cmd_app.cpp
```

### Version Mismatch

The git repository may have a newer version than tagged releases. The actual executable version is determined at compile time from the source, not from `lure.sh`.

## License

pk2cmd is distributed under Microchip's proprietary license. See the LICENSE file for terms.

## See Also

- [jaka-fi/pk2cmd GitHub](https://github.com/jaka-fi/pk2cmd)
- [PICkitminus GUI](https://github.com/jaka-fi/PICkitminus) (Windows only)
- [pk2cmd-plus](../pk2cmd-plus/) — Alternative LURE package (PICkit 2 only)
- [LURE Documentation](https://github.com/lure-sh/lure/tree/master/docs)
