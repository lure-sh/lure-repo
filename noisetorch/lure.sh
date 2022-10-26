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

sources_amd64=("git+https://github.com/noisetorch/NoiseTorch.git#tag=v${version}"
	#"git+https://github.com/noisetorch/c-ringbuf.git"
	#"git+https://github.com/noisetorch/rnnoise.git"
)
checksums_amd64=('SKIP'
	#'SKIP'
	#'SKIP'
)

prepare() {
	cd "${srcdir}/NoiseTorch"
	#git submodule init
	#git config submodule."c/c-ringbuf.url" "${srcdir}/c-ringbuf"
	#git config submodule."c/rnnoise.url" "${srcdir}/rnnoise"
	#git submodule update
}

build() {
	cd "${srcdir}/NoiseTorch"
	#export GOPATH="${srcdir}/go"
	#pushd "c/ladspa"
	make
	#popd
	#vendor_flags="-X main.version=${version}"
	#export CGO_CPPFLAGS="${CPPFLAGS}"
	#export CGO_CFLAGS="${CFLAGS}"
	#export CGO_CXXFLAGS="${CXXFLAGS}"
	#export CGO_LDFLAGS="${LDFLAGS}"
	#export GOFLAGS="-buildmode=pie -trimpath -mod=readonly -modcacherw"
	#go generate
	#go build -ldflags "${vendor_flags} -linkmode=external" -o bin/noisetorch
	#go clean -modcache
}

package() {
	install -Dm755 "${srcdir}/NoiseTorch/bin/noisetorch" "${pkgdir}/usr/bin/noisetorch"
	install -Dm644 "${srcdir}/NoiseTorch/assets/noisetorch.desktop" "${pkgdir}/usr/share/applications/noisetorch.desktop"
	install -Dm644 "${srcdir}/NoiseTorch/assets/icon/noisetorch.png" "${pkgdir}/usr/share/icons/hicolor/256x256/apps/noisetorch.png"
}
