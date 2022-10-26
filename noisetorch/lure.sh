name='noisetorch'
version='0.12.2'
release='1'
desc='NoiseTorch-ng is an easy to use open source application for Linux with PulseAudio or PipeWire. It creates a virtual microphone that suppresses noise, in any application.'
homepage='https://github.com/noisetorch/NoiseTorch'
architectures=('amd64')
license=('GPLv3')
provides=('noisetorch')
conflicts=('noisetorch')

deps_amd64=('git go')
build_deps=('git' 'go')

sources_amd64=("git+https://github.com/noisetorch/NoiseTorch.git#tag=v${version}")
checksums_amd64=('SKIP')

prepare() {
	    cd "${srcdir}/NoiseTorch"
}

build() {
	    cd "${srcdir}/NoiseTorch"
	    make
}

package() {
     	install -Dm755 "${srcdir}/NoiseTorch/bin/noisetorch" "${pkgdir}/usr/bin/noisetorch"
     	install -Dm644 "${srcdir}/NoiseTorch/assets/noisetorch.desktop" "${pkgdir}/usr/share/applications/noisetorch.desktop"
	    install -Dm644 "${srcdir}/NoiseTorch/assets/icon/noisetorch.png" "${pkgdir}/usr/share/icons/hicolor/256x256/apps/noisetorch.png"
}
