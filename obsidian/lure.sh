name='obsidian'
version='1.0.0'
release='1'
desc='A powerful knowledge base that works on top of a local folder of plain text Markdown files'
homepage='https://obsidian.md/'
architectures=('amd64')
license=('custom:Commercial')
provides=('obsidian')
conflicts=('obsidian')

deps=('zlib' 'hicolor-icon-theme' 'fuse3')
build_deps=('npm')

sources_amd64=("https://github.com/obsidianmd/obsidian-releases/releases/download/v${version}/obsidian-${version}.tar.gz")
checksums_amd64=('1f50a5f52073fe6c0df207b3164715e0ac48efec558d057602dc8b2b28d5a48f')

prepare() {
cd ~/.npm
npm install --engine-strict asar
npm install electron --save-dev

cd "${srcdir}"
~/.npm/node_modules/asar/bin/asar.js ef "${name}-${version}/resources/obsidian.asar" icon.png
echo "[Desktop Entry]" >> obsidian.desktop
echo "Name=Obsidian" >> obsidian.desktop
echo "Exec=/usr/bin/obsidian %U" >> obsidian.desktop
echo "Terminal=false" >> obsidian.desktop
echo "Type=Application" >> obsidian.desktop
echo "Icon=obsidian" >> obsidian.desktop
echo "StartupWMClass=obsidian" >> obsidian.desktop
echo "Comment=Obsidian" >> obsidian.desktop
echo "MimeType=x-scheme-handler/obsidian;" >> obsidian.desktop
echo "Categories=Office;" >> obsidian.desktop
echo "#!/bin/sh" >> "${name}"
echo "exec ~/.npm/node_modules/electron/dist/electron /usr/lib/obsidian/app.asar \"\$@\"" >> "${name}"
}

package() {
# binaries
install -Dm755 "${name}" "${pkgdir}/usr/bin/obsidian"

# desctop file
install -Dm644 "${name}.desktop" -t "${pkgdir}/usr/share/applications/"
install -Dm644 ./icon.png "${pkgdir}/usr/share/pixmaps/obsidian.png"
cd "${srcdir}/${name}-${version}/resources/"
install -dm0755 "$pkgdir/usr/lib/obsidian"
find . -type d -exec install -d {,"${pkgdir}/usr/lib/obsidian/"}{} \;
find . -type f -exec install -D {,"${pkgdir}/usr/lib/obsidian/"}{} \;
}