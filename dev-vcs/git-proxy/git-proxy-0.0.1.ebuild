# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils

DESCRIPTION="Use socat to proxy git through an HTTP CONNECT firewall"
HOMEPAGE="http://tinyurl.com/8xvpny"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="sys-apps/sed
			net-misc/socat
			dev-vcs/git"
RDEPEND="${DEPEND}"

src_unpack() {
	mkdir -p "${S}"
}

src_prepare() {
	cp "${FILESDIR}"/${P} "${S}"/${PN} || die
}

src_install() {
	dobin "${S}"/${PN}
}

pkg_postinst() {
	elog "Configuration: set the proxy (and user/password) in the http_proxy"
	elog "environmet variable."
	elog " "
	elog "To enable git-proxy add it to your git configuration."
	elog "To add it for the actual user:"
	elog "	git config --global core.gitproxy git-proxy"
	elog " "
	elog "To add it for globally for all users:"
	elog "	git config --system core.gitproxy git-proxy"
	
}
