name="pk2cmd-jaka-fi"
version="1.26.06"
release="1"
desc="PICkit 2/3/PKOB CLI programmer with extended device support (1588 devices)"
homepage="https://github.com/jaka-fi/pk2cmd"
maintainer="Foad Sojoodi Farimani <f.s.farimani@gmail.com>"
architectures=("amd64" "386")
license=("Custom")
provides=("pk3cmd")
conflicts=("pk2cmd-plus")

# Debian/Ubuntu Dependencies
# This fork uses libusb-1.0 (not the legacy 0.1 compatibility layer)
deps=("libusb-1.0-0")
build_deps=("build-essential" "libusb-1.0-0-dev")

sources=(
    "git+https://github.com/jaka-fi/pk2cmd.git"
)

checksums=(
    "SKIP"
)

prepare() {
    cd "$srcdir/pk2cmd/pk2cmd"
    
    # The source code falls back to searching current directory for PK2DeviceFile.dat
    # Change the fallback from "PK2DeviceFile.dat" (17 chars) to "/usr/share/pk2/PK2DeviceFile.dat" (33 chars)
    # Note: Line 116 has this commented out, we fix line 121 instead
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
    
    # Install the executable as pk3cmd to avoid conflict with pk2cmd-plus
    install -Dm755 pk2cmd "${pkgdir}/usr/bin/pk3cmd"
    
    # Also create symlink for original name (user can choose which to use)
    # Commented out to avoid conflicts - uncomment if pk2cmd-plus is not installed
    # ln -s pk3cmd "${pkgdir}/usr/bin/pk2cmd"
    
    # Install the Device File (v2.63.218 with 1588 devices)
    install -Dm644 PK2DeviceFile.dat "${pkgdir}/usr/share/pk2/PK2DeviceFile.dat"
    
    # Install firmware hex files
    for hex in ../release/*.hex; do
        [ -f "$hex" ] && install -Dm644 "$hex" "${pkgdir}/usr/share/pk2/$(basename "$hex")"
    done
    
    # Install udev rules (supports PICkit2, PICkit3, and PKOB)
    install -Dm644 "$srcdir/pk2cmd/60-pickit.rules" "${pkgdir}/usr/lib/udev/rules.d/60-pickit.rules"
    
    # Install license
    install -Dm644 "$srcdir/pk2cmd/license.txt" "${pkgdir}/usr/share/licenses/${name}/LICENSE"
}
