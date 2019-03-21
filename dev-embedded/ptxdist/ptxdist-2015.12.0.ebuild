# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit multilib autotools-utils

DESCRIPTION="""PTXdist is a tool which can be used to generate a root tree for all
			kinds of Linux systems."""
HOMEPAGE="http://www.pengutronix.de/software/ptxdist/"
SRC_URI="http://www.pengutronix.de/software/ptxdist/download/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="2015"
KEYWORDS="~amd64"
IUSE="doc"

DEPEND="doc? ( dev-python/sphinx )"
RDEPEND="${DEPEND}"

AUTOTOOLS_IN_SOURCE_BUILD=1
DOCS=(README README.devel)

src_configure() {
	autotools-utils_src_configure
}

src_compile() {
	autotools-utils_src_compile
	if use doc; then
		HTML_DOCS=${BUILD_DIR}/Documentation/html/

		cd ${BUILD_DIR}
		emake docs
	fi
}

src_install() {
	autotools-utils_src_install
	rm -f ${D}/usr/bin/ptxdist
}

pkg_postinst() {
	einfo "Activating ${P}."
	rm -f ${ROOT}/usr/bin/ptxdist
	ln -s ${ROOT}/usr/lib64/${P}/bin/ptxdist-auto-version ${ROOT}/usr/bin/ptxdist
}

pkg_postrm() {
	rm -f ${ROOT}/usr/bin/ptxdist
}
