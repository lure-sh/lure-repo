name='zynaddsubfx-git'
version='3.0.7'
release='0'
desc='ZynAddSubFX open source synthesizer (only lv2)'
homepage='https://zynaddsubfx.sourceforge.io'
maintainer="Nil Geisweiller <ngeiswei@gmail.com>"
architectures=('amd64')
license=('GPL-2.0')
provides=('zynaddsubfx')
conflicts=('zynaddsubfx')
build_deps=('cmake' 'gcc' 'g++' 'libfftw3-dev' 'libmxml-dev' 'liblo-dev' 'zlib1g-dev')
sources=("git+https://github.com/zynaddsubfx/zyn-fusion-build.git")
checksums=('SKIP')

version() {
	cd "${srcdir}/zyn-fusion-build"
	git-version
}

build() {
	cd "${srcdir}/zyn-fusion-build"
	PARALLEL=1 make -f Makefile.linux.mk all
}

package() {
	# Create /opt/zyn-fusion and /usr/lib/lv2 folders
	mkdir -p "${pkgdir}/opt/zyn-fusion"
	mkdir -p "${pkgdir}/usr/lib/lv2/"
	mkdir -p "${pkgdir}/usr/share/zynaddsubfx/"
	# Copy build folder tree into /opt/zyn-fusion
	cp -a "${srcdir}/zyn-fusion-build/build/zyn-fusion-linux-64bit-3.0.7-demo/"* "${pkgdir}/opt/zyn-fusion"
	# Build symbol links
	ln -s "${pkgdir}/opt/zyn-fusion/ZynAddSubFX.lv2" "${pkgdir}/usr/lib/lv2"
	ln -s "${pkgdir}/opt/zyn-fusion/ZynAddSubFX.lv2presets" "${pkgdir}/usr/lib/lv2"
	ln -s "${pkgdir}/opt/zyn-fusion/banks" "${pkgdir}/usr/share/zynaddsubfx/banks"
}
