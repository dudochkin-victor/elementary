# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit gnome2-utils autotools-utils bzr

DESCRIPTION="The Date and Time Indicator - A very, very simple clock"
HOMEPAGE="https://launchpad.net/indicator-datetime"
EBZR_REPO_URI="lp:indicator-datetime"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE="static-libs"

RDEPEND="
	app-misc/geoclue
	dev-libs/glib:2
	>=dev-libs/libdbusmenu-0.5.90:3[gtk]
	dev-libs/libical
	dev-libs/libindicator:3
	gnome-base/gconf
	>=gnome-extra/evolution-data-server-3.5.3
	x11-libs/cairo
	>=x11-libs/gtk+-3.1.4:3
	x11-libs/libido:3"
DEPEND="${RDEPEND}"

pkg_preinst() {
	gnome2_schemas_savelist
}

pkg_postinst() {
	gnome2_schemas_update
}

pkg_postrm() {
	gnome2_schemas_update
}

