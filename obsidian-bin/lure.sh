name='obsidian-bin'
version='1.1.9'
release='1'
desc='A powerful knowledge base that works on top of a local folder of plain text Markdown files'
homepage='https://obsidian.md/'
maintainer="Евгений Храмов <xpamych@yandex.ru>"
architectures=('amd64')
license=('custom:Commercial')
provides=('obsidian')
conflicts=('obsidian')

deps=('zlib' 'hicolor-icon-theme' 'fuse3')
deps_debian=('zlib1g' 'hicolor-icon-theme' 'fuse3')
build_deps=('npm')

sources_amd64=("https://github.com/obsidianmd/obsidian-releases/releases/download/v${version}/${provides}-${version}.tar.gz")
checksums_amd64=('SKIP')

prepare() {
	mkdir ~/.npm
	cd ~/.npm
	npm install --engine-strict asar
	npm install electron --save-dev

	cd "${srcdir}"
	~/.npm/node_modules/asar/bin/asar.js ef "${provides}-${version}/resources/obsidian.asar" icon.png
}

package() {
	install -Dm755 "${scriptdir}/${provides}" "${pkgdir}/usr/bin/obsidian"
	install -Dm644 "${scriptdir}/${provides}.desktop" -t "${pkgdir}/usr/share/applications/"
	install -Dm644 ./icon.png "${pkgdir}/usr/share/pixmaps/obsidian.png"
	cd "${srcdir}/${provides}-${version}/resources/"
	install -dm0755 "$pkgdir/usr/lib/obsidian"
	find . -type d -exec install -d {,"${pkgdir}/usr/lib/obsidian/"}{} \;
	find . -type f -exec install -D {,"${pkgdir}/usr/lib/obsidian/"}{} \;
}
