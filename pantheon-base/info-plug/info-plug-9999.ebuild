# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit cmake-utils bzr

DESCRIPTION="Information plug for switchboard"
HOMEPAGE="https://code.launchpad.net/~elementary-os/pantheon-plugs/info-plug"
EBZR_REPO_URI="lp:~elementary-os/pantheon-plugs/info-plug"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="
	pantheon-base/libpantheon
	pantheon-base/switchboard"
DEPEND="${RDEPEND}
	dev-lang/vala:0.16
	dev-util/pkgconfig"

src_prepare() {
	sed -i 's/distributor=Ubuntu/distributor=Gentoo/' data/elementary.info
}

src_configure() {
	local mycmakeargs=(
		-DVALA_EXECUTABLE="$(type -p valac-0.16)"
	)

	cmake-utils_src_configure
}

