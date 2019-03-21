# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"

PYTHON_COMPAT=( python2_7 )
PYTHON_REQ_USE='threads(+)' # required by waf

inherit python-single-r1 waf-utils

DESCRIPTION="Time tracking for the masses"
HOMEPAGE="http://projecthamster.wordpress.com"
#EGIT_REPO_URI="https://github.com/projecthamster/hamster.git"
#EGIT_REPO_URI="https://github.com/michaelkuhn/hamster.git" # use as long patch is not integrated into official hamster
#EGIT_BRANCH="fix-division-by-zero"
SRC_URI="https://api.github.com/repos/michaelkuhn/hamster/tarball/fix-division-by-zero -> ${P}.tar.gz"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="
	dev-python/gconf-python
	gnome-base/gconf[introspection]
	dev-python/pyxdg
	>=x11-libs/gtk+-3.10
	sys-devel/gettext"
DEPEND="${RDEPEND}
	dev-util/intltool"

pkg_setup() {
	python-single-r1_pkg_setup
}

src_unpack() {
	unpack ${A}
	mv michaelkuhn-hamster-* ${P} || die
}

src_prepare() {
	python_fix_shebang .
}
