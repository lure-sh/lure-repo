name='telegram-desktop-bin'
version='4.9.2'
release='1'
desc='Official desktop version of Telegram messaging app - Static binaries'
homepage='https://github.com/telegramdesktop/tdesktop'
maintainer="Евгений Храмов <xpamych@yandex.ru>"
architectures=('amd64')
license=('GPLv3')
provides=('telegram-desktop')
conflicts=('telegram-desktop')
deps=('desktop-file-utils' 'glib2' 'hicolor-icon-theme' 'dbus-libs' 'libX11' 'libappindicator-gtk3' 'xdg-utils')
deps_rosa=('desktop-file-utils' 'glib2' 'hicolor-icon-theme' 'lib64dbus-1_3' 'libX11' 'lib64appindicator3_1' 'xdg-utils')
build_deps=('chrpath')

sources=(
	"${homepage}/raw/master/Telegram/Resources/art/icon16.png"
	"${homepage}/raw/master/Telegram/Resources/art/icon32.png"
	"${homepage}/raw/master/Telegram/Resources/art/icon48.png"
	"${homepage}/raw/master/Telegram/Resources/art/icon64.png"
	"${homepage}/raw/master/Telegram/Resources/art/icon128.png"
	"${homepage}/raw/master/Telegram/Resources/art/icon256.png"
	"${homepage}/raw/master/Telegram/Resources/art/icon512.png"
	"${homepage}/releases/download/v${version}/tsetup.${version}.tar.xz")
checksums=(
	'SKIP'
	'SKIP'
	'SKIP'
	'SKIP'
	'SKIP'
	'SKIP'
	'SKIP'
	'SKIP'
)

package() {

	cd "${srcdir}/"

	# Creating needed directories
	mkdir -p "${pkgdir}/usr/bin"
	mkdir -p "${pkgdir}/usr/share/pixmaps/"
	mkdir -p "${pkgdir}/usr/share/applications"
	# Program
	install -Dm755 "${srcdir}/Telegram/Telegram" "${pkgdir}/usr/bin/telegram-desktop"

	# Remove RPATH informations
	chrpath --delete "${pkgdir}/usr/bin/telegram-desktop"

	# Desktop launcher
	install -Dm644 "${srcdir}/icon256.png" "${pkgdir}/usr/share/pixmaps/telegram.png"
	install -Dm644 "${scriptdir}/${name}.desktop" "${pkgdir}/usr/share/applications/telegramdesktop.desktop"

	# KDE5 & KDE4 protocol file
	install -d "${pkgdir}/usr/share/kservices5"
	install -d "${pkgdir}/usr/share/kde4/services"
	install -m644 "${scriptdir}/tg.protocol" "${pkgdir}/usr/share/kservices5/tg.protocol"
	ln -s "/usr/share/kservices5/tg.protocol" "${pkgdir}/usr/share/kde4/services"

	# Icons
	local icon_size icon_dir
	for icon_size in 16 32 48 64 128 256 512; do
		icon_dir="${pkgdir}/usr/share/icons/hicolor/${icon_size}x${icon_size}/apps"
		install -d "${icon_dir}"
		install -m644 "${srcdir}/icon${icon_size}.png" "${icon_dir}/telegram.png"
	done

	# Disable the official Telegram Desktop updater
	mkdir -p "${pkgdir}/etc/tdesktop"
	echo "/usr/bin/telegram-desktop" >"${pkgdir}/etc/tdesktop/externalupdater"
}
