# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit gnome2-utils cmake-utils bzr

DESCRIPTION="Collection of contracts for various web services"
HOMEPAGE="https://launchpad.net/webcontracts"
EBZR_REPO_URI="lp:webcontracts"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="
	dev-libs/glib:2
	dev-libs/json-glib
	net-libs/libsoup:2.4
	net-libs/rest
	net-libs/webkit-gtk:3
	pantheon-base/libpantheon
	x11-libs/granite"
DEPEND="${RDEPEND}
	dev-lang/vala:0.18
	virtual/pkgconfig"

src_configure() {
	local mycmakeargs=(
		-DGSETTINGS_COMPILE=OFF
		-DVALA_EXECUTABLE="$(type -p valac-0.18)"
	)

	cmake-utils_src_configure
}

pkg_preinst() {
	gnome2_schemas_savelist
}

pkg_postinst() {
	gnome2_schemas_update
}

pkg_postrm() {
	gnome2_schemas_update
}

