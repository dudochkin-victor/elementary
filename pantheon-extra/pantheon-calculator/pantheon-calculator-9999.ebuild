# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit gnome2-utils cmake-utils bzr

DESCRIPTION="Tiny, simple calculator written in GTK+ and Vala"
HOMEPAGE="https://launchpad.net/pantheon-calculator"
EBZR_REPO_URI="lp:pantheon-calculator"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="
	dev-libs/glib:2
	x11-libs/granite
    x11-libs/gtk+:3"
DEPEND="${RDEPEND}
	dev-lang/vala:0.16
	dev-util/pkgconfig"

pkg_setup() {
	DOCS=( AUTHORS COPYING COPYRIGHT )
}

src_configure() {
	local mycmakeargs=(
		-DVALA_EXECUTABLE="$(type -p valac-0.16)"
	)

	cmake-utils_src_configure
}

pkg_preinst() {
	gnome2_icons_savelist
}

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}

