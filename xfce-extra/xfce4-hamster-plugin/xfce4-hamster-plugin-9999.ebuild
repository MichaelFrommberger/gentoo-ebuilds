# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
EAUTORECONF=1
inherit xfconf

DESCRIPTION="""This is a recreation of the gnome-shell hamster extension
			as a xfce4 panel plugin"""
HOMEPAGE="http://projecthamster.wordpress.com"
EGIT_REPO_URI="https://github.com/projecthamster/xfce4-hamster-plugin.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="debug"

RDEPEND="
	app-office/hamster-time-tracker
	xfce-base/xfce4-panel
	xfce-base/libxfce4util"
DEPEND="${RDEPEND}
	dev-util/intltool"

pkg_setup() {
	XFCONF=(
		$(xfconf_use_debug)
		)

	DOCS=( AUTHORS ChangeLog NEWS README README.md )
}

src_configure() {
	XFCONF+=( --with-icon_name=hamster-time-tracker )
	xfconf_src_configure
}

