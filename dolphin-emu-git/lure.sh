name='dolphin-emu-git'
version='38515.f4b1155b4d'
release=1
architectures=('amd64')

build_deps=('g++' 'pkg-config' 'libudev-dev' 'libevdev-dev' 'qtbase5-dev' 'qtbase5-private-dev' 'libxi-dev')

sources=('git+https://github.com/dolphin-emu/dolphin.git')
checksums=('SKIP')

build() {
    cd "$srcdir/dolphin"
    git submodule update --init --recursive
    mkdir "build" && cd "build"
    cmake ..
    make -j$(nproc)
}

package() {

}
