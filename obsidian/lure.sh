name='obsidian'
version='1.1.8'
release='2'
desc='A powerful knowledge base that works on top of a local folder of plain text Markdown files'
homepage='https://obsidian.md/'
architectures=('amd64')
license=('custom:Commercial')
provides=('obsidian')
conflicts=('obsidian')

deps_amd64=('zlib' 'hicolor-icon-theme' 'fuse3')
deps_amd64_debian=('zlib1g' 'hicolor-icon-theme' 'fuse3')
build_deps=('npm')

sources_amd64=("https://github.com/obsidianmd/obsidian-releases/releases/download/v${version}/${name}-${version}.tar.gz")
checksums_amd64=('SKIP')

prepare() {
	cd ~/.npm
	npm install --engine-strict asar
	npm install electron --save-dev

	cd "${srcdir}"
	~/.npm/node_modules/asar/bin/asar.js ef "${name}-${version}/resources/obsidian.asar" icon.png
}

package() {
	install -Dm755 "${scriptdir}/${name}" "${pkgdir}/usr/bin/obsidian"
	install -Dm644 "${scriptdir}/${name}.desktop" -t "${pkgdir}/usr/share/applications/"
	install -Dm644 ./icon.png "${pkgdir}/usr/share/pixmaps/obsidian.png"
	cd "${srcdir}/${name}-${version}/resources/"
	install -dm0755 "$pkgdir/usr/lib/obsidian"
	find . -type d -exec install -d {,"${pkgdir}/usr/lib/obsidian/"}{} \;
	find . -type f -exec install -D {,"${pkgdir}/usr/lib/obsidian/"}{} \;
}
