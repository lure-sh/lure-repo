name='z88dk-git'
version='21835.e89d1b4477'
release=3
desc='The development kit for Z80 computers'
homepage='https://github.com/z88dk/z88dk'
maintainer='Atirut Wattanamongkol <atirut.wattanamnogkol@gmail.com>'
architectures=('amd64')
license=('MIT')

sources=('git+https://github.com/z88dk/z88dk?~recursive=true&~rev=e89d1b4477687747b500fbe0e25fc52fe35056a7')
checksums=('SKIP')

build_deps_ubuntu=('build-essential' 'bison' 'flex' 'libxml2-dev' 'subversion' 'zlib1g-dev' 'm4' 'ragel' 're2c' 'dos2unix' 'texinfo' 'texi2html' 'gdb' 'curl' 'perl' 'cpanminus' 'ccache' 'libboost-all-dev' 'libmodern-perl-perl' 'libyaml-perl' 'liblocal-lib-perl' 'libcapture-tiny-perl' 'libpath-tiny-perl' 'libtext-table-perl' 'libdata-hexdump-perl' 'libregexp-common-perl' 'libclone-perl' 'libfile-slurp-perl' 'pkg-config')

version() {
	cd "$srcdir/z88dk"
	git-version
}

prepare() {
	cpanm --local-lib="$srcdir/perl5" App::Prove CPU::Z80::Assembler Data::Dump Data::HexDump File::Path List::Uniq Modern::Perl Object::Tiny::RW Regexp::Common Test::Harness Text::Diff Text::Table YAML::Tiny
	eval $(perl -I "$srcdir/perl5/lib/perl5/" -Mlocal::lib)
}

build() {
	cd "$srcdir/z88dk"
	export BUILD_SDCC=1 BUILD_SDCC_HTTP=1
	PREFIX="/usr" DESTDIR="$pkgdir" ./build.sh
}

package() {
	cd "$srcdir/z88dk"
	PREFIX="/usr" DESTDIR="$pkgdir" make install
}
