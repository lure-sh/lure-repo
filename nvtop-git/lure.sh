name='nvtop-git'
version='3.2.0'
release='0'
desc='GPU & Accelerator process monitoring for AMD, Apple, Huawei, Intel, NVIDIA and Qualcomm'
homepage='https://github.com/Syllo/nvtop'
maintainer="Nil Geisweiller <ngeiswei@gmail.com>"
architectures=('amd64')
license=('GPL-3.0-or-later')
provides=('nvtop')
conflicts=('nvtop')
build_deps=('cmake' 'gcc' 'g++' 'libncurses-dev')
sources=("git+https://github.com/Syllo/nvtop.git")
checksums=('SKIP')

version() {
	cd "${srcdir}/nvtop"
	git-version
}

build() {
	cd "${srcdir}/nvtop"
	mkdir build
	cd build
	cmake .. -DNVIDIA_SUPPORT=ON -DAMDGPU_SUPPORT=ON -DINTEL_SUPPORT=ON -DCMAKE_INSTALL_PREFIX="${pkgdir}/usr"
	make -j
}

package() {
	cd "${srcdir}/nvtop/build"
	make install
}
