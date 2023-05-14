name='z88dk-git'
version='21023.a09ee3d7a'
release=1
architectures=('amd64')

sources=("git+https://github.com/z88dk/z88dk?~recursive=true")
checksums=('SKIP')

build() {
	export BUILD_SDCC=1
	export BUILD_SDCC_HTTP=1
	cd "$srcdir/z88dk"
	./build.sh
}

package() {

}
