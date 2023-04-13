name='hlna-git'
version='latest'
release='1'
desc='Этот инструмент позволяет управлять выделенным сервером ARK: Survival Evolved на Linux. Он предоставляет множество функций, чтобы получить полный список, ознакомьтесь с разделом использования. (находится в разарботке и может содержать ошибки)'
homepage='https://gitflic.ru/project/xpamych/hlna'
maintainer="Евгений Храмов <xpamych@yandex.ru>"
architectures=('amd64')
license=('GPL-3.0-or-later')
provides=('hlna')
conflicts=('hlna')

build_deps=('python3' 'python3-pip' 'steamcmd')
build_deps_arch=('python' 'python-pip' 'steamcmd')

sources=("git+https://gitflic.ru/project/xpamych/hln-a.git")
checksums=('SKIP')

version() {
	cd "$srcdir/hln-a"
	git-version
}

scripts=(
	['postinstall']='postinstall.sh'
	['postremove']='postremove.sh'
)

prepare() {
	pip3 install --upgrade --user click colorama click_completion pyTelegramBotAPI discord
	pip3 install --upgrade rcon
}

package() {
	install -Dm755 "${srcdir}/hln-a/hlna.py" "${pkgdir}/usr/bin/hlna.py"
	install -Dm755 "${srcdir}/hln-a/hlna_bot.py" "${pkgdir}/usr/bin/hlna-bot.py"
	install -Dm644 "${srcdir}/hln-a/LICENSE.md" "${pkgdir}/usr/share/licenses/hlna/license"
}
