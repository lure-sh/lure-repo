name="pk2cmd-plus"
version="1.21~rc1+1.63.148"
release="2"
desc="PICkit 2 CLI software with updated DeviceFile and udev rules"
homepage="http://www.microchip.com/pickit2"
maintainer="BxS <bxsbxs at gmail dot com>"
architectures=("amd64" "386")
license=("Custom")
provides=("pk2cmd")
conflicts=("pk2cmd")

# Debian/Ubuntu Dependencies
deps=("libusb-0.1-4")
build_deps=("build-essential" "libusb-dev")

sources=(
    # 1. Main Source Code - Use GitHub mirror (avoids LURE ZIP extraction bug)
    "git+https://github.com/psmay/pk2cmd.git"
    # 2. Device File - Use GitHub from martonmiklos fork (has updated device files)
    "https://raw.githubusercontent.com/martonmiklos/pk2cmd/master/pk2cmd/PK2DeviceFile.dat"
    # 3. Udev Rules (from AUR)
    "https://aur.archlinux.org/cgit/aur.git/plain/60-pickit2.rules?h=pk2cmd-plus"
    # 4. License (from AUR)  
    "https://aur.archlinux.org/cgit/aur.git/plain/LICENSE?h=pk2cmd-plus"
)

checksums=(
    "SKIP"
    "SKIP"
    "SKIP"
    "SKIP"
)

prepare() {
    cd "$srcdir/pk2cmd/pk2cmd"
    
    # Convert CRLF to LF (source may have Windows line endings)
    sed -i 's/\r$//' cmd_app.cpp
    
    # The source code falls back to searching current directory for PK2DeviceFile.dat
    # Change the fallback from "PK2DeviceFile.dat" (17 chars) to "/usr/share/pk2/PK2DeviceFile.dat" (33 chars)
    # This is the line: _tcsncpy_s(tempString, "PK2DeviceFile.dat", 17);
    sed -i 's|_tcsncpy_s(tempString, "PK2DeviceFile.dat", 17)|_tcsncpy_s(tempString, "/usr/share/pk2/PK2DeviceFile.dat", 33)|g' cmd_app.cpp
    
    # Verify the change was made
    if grep -q '/usr/share/pk2/PK2DeviceFile.dat' cmd_app.cpp; then
        echo "Path substitution successful"
    else
        echo "ERROR: Path substitution failed!"
        exit 1
    fi
}

build() {
    cd "$srcdir/pk2cmd/pk2cmd"
    make linux
}

package() {
    cd "$srcdir/pk2cmd/pk2cmd"
    
    # Install the executable
    install -Dm755 pk2cmd "${pkgdir}/usr/bin/pk2cmd"
    
    # Install the Device File
    install -Dm644 "$srcdir/PK2DeviceFile.dat" "${pkgdir}/usr/share/pk2/PK2DeviceFile.dat"
    
    # Install firmware hex file if present (may not be in GitHub mirror)
    if [ -f "$srcdir/pk2cmd/release/PK2V023200.hex" ]; then
        install -Dm644 "$srcdir/pk2cmd/release/PK2V023200.hex" "${pkgdir}/usr/share/pk2/PK2V023200.hex"
    elif [ -f "../release/PK2V023200.hex" ]; then
        install -Dm644 "../release/PK2V023200.hex" "${pkgdir}/usr/share/pk2/PK2V023200.hex"
    fi
    
    # Install Udev rules (Debian location)
    install -Dm644 "$srcdir/60-pickit2.rules" "${pkgdir}/usr/lib/udev/rules.d/60-pickit2.rules"
    
    # Install License
    install -Dm644 "$srcdir/LICENSE" "${pkgdir}/usr/share/licenses/${name}/LICENSE"
}
