EAPI=4

inherit fdo-mime gnome2-utils autotools-utils bzr

DESCRIPTION="The dock for elementary Pantheon, built on the awesome foundation of Plank"
HOMEPAGE="https://launchpad.net/pantheon-dock"
EBZR_REPO_URI="lp:pantheon-dock"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="debug nls static-libs"

RDEPEND="
	x11-libs/libX11
	dev-libs/libgee:0
	dev-libs/libunique:1
	x11-libs/libwnck:1
	>=x11-libs/bamf-0.2.58
	>=dev-libs/glib-2.26.0:2
	>=x11-libs/gtk+-2.22.0:2
	!pantheon-base/plank"
DEPEND="${RDEPEND}
	dev-lang/vala:0.18[vapigen]
	dev-util/intltool
	dev-util/pkgconfig
	gnome-base/gnome-common
	nls? ( sys-devel/gettext )"

pkg_setup() {
	AUTOTOOLS_IN_SOURCE_BUILD=1
	DOCS=(AUTHORS COPYING COPYRIGHT NEWS README)
}

src_prepare() {
	NOCONFIGURE=1 ./autogen.sh
}

src_configure() {
	local myeconfargs=(
		VALAC="$(type -p valac-0.18)"
		VAPIGEN="$(type -p vapigen-0.18)"
		$(use_enable debug)
		$(use_enable nls)
	)

	autotools-utils_src_configure
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	gnome2_icon_cache_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	gnome2_icon_cache_update
}

