name='obsidian-bin'
version='1.1.15'
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

sources_amd64=("https://github.com/obsidianmd/obsidian-releases/releases/download/v${version}/obsidian-${version}.tar.gz")
checksums_amd64=('SKIP')

prepare() {
	mkdir ~/.npm
	cd ~/.npm
	npm install --engine-strict asar
	npm install electron --save-dev

	cd "${srcdir}"
	~/.npm/node_modules/asar/bin/asar.js ef "obsidian-${version}/resources/obsidian.asar" icon.png
}

package() {
	install -Dm755 "${scriptdir}/obsidian" "${pkgdir}/usr/bin/obsidian"
	install -Dm644 "${scriptdir}/obsidian.desktop" -t "${pkgdir}/usr/share/applications/"
	install -Dm644 ./icon.png "${pkgdir}/usr/share/pixmaps/obsidian.png"
	mkdir -p "${pkgdir}/usr/lib/obsidian"
	cp -a "${srcdir}/obsidian-${version}/resources/." "${pkgdir}/usr/lib/obsidian"
}
