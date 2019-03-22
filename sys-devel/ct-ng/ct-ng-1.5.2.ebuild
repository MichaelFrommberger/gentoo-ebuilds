# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"

inherit autotools bash-completion-r1 eutils

DESCRIPTION="crosstool-ng is a tool to build cross-compiling toolchains"
HOMEPAGE="http://crosstool-ng.org"
MY_P=${P/ct/crosstool}
S="${WORKDIR}/crosstool-ng-${PV}"
SRC_URI="http://ymorin.is-a-geek.org/download/crosstool-ng/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="net-misc/curl
	dev-util/gperf
	dev-vcs/cvs
	dev-vcs/subversion"

src_prepare() {
	epatch "${FILESDIR}"/${P}_makeflags.patch
}

src_configure() {
	./configure --prefix="/opt/${P}"
}

src_install() {
	emake DESTDIR="${D%/}" install
	dosym /opt/${P} /opt/${PN}
}
