# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit fdo-mime gnome2-utils cmake-utils

DESCRIPTION="Noise is the official audio player of elementary OS"
HOMEPAGE="https://launchpad.net/noise"
SRC_URI="https://launchpad.net/${PN}/0.x/luna-beta1/+download/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="ayatana menu nls plugins upnp zeitgeist"

REQUIRED_USE="upnp? ( plugins )"

RDEPEND="
	dev-db/sqlheavy
	dev-libs/glib:2
	dev-libs/json-glib
	menu? ( >=dev-libs/libdbusmenu-0.4.3 )
	dev-libs/libgee:0
	ayatana? ( >=dev-libs/libindicate-0.5.90 )
	zeitgeist? ( >=dev-libs/libzeitgeist-0.3.10 )
	dev-libs/libxml2:2
	media-libs/gstreamer
	media-libs/gst-plugins-base
	media-libs/libgpod
	media-libs/taglib
	plugins? ( upnp? ( net-libs/gupnp-vala ) )
	net-libs/libsoup:2.4
	x11-libs/gtk+:3
	x11-libs/granite
	x11-libs/libnotify"
DEPEND="${RDEPEND}
	dev-lang/vala:0.16
	dev-util/pkgconfig"

pkg_setup() {
	S="${WORKDIR}"
	DOCS=( AUTHORS COPYING NEWS README )
}

src_prepare() {
	# Disable generation of the translations (if needed)
	use nls || sed -i 's/add_subdirectory(po)//' CMakeLists.txt

	# Disable building of plugins (if needed)
	use plugins || sed -i 's/add_subdirectory(plugins)//' CMakeLists.txt
}

src_configure() {
	local mycmakeargs=(
		-DICON_UPDATE=OFF
		-DGSETTINGS_COMPILE=OFF
		-DVALA_EXECUTABLE="$(type -p valac-0.16)"
	)

	cmake-utils_src_configure
}

pkg_preinst() {
	gnome2_icon_savelist
	gnome2_schemas_savelist
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	gnome2_icon_cache_update
	gnome2_schemas_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	gnome2_icon_cache_update
	gnome2_schemas_update
}

