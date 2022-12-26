name='dolphin-emu-git'
version='38515.f4b1155b4d'
release=1
architectures=('amd64')

build_deps=('g++')

sources=('git+https://github.com/dolphin-emu/dolphin.git')
checksums=('SKIP')

build() {
    cd "$srcdir/dolphin"
    mkdir "build" && cd "build"
    cmake ..
}

package() {

}
