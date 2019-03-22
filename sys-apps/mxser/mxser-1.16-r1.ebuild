# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit eutils linux-mod udev

DESCRIPTION="The Moxa Smartio/Industio utilities and kernel modules"
HOMEPAGE="http://www.moxa.com/support/sarch_result.aspx?type=soft&prod_id=76&type_id=9"
SRC_URI="driv_linux_smart_v${PV}_build_14030317.tgz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="utils"
RESTRICT="fetch"

DEPEND="virtual/udev"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${PN}

MODULE_NAMES="mxser(char/:${S}/driver) mxupcie(char/:${S}/driver)"

pkg_nofetch() {
	einfo "Please visit this URL to download the package:"
	einfo "${HOMEPAGE}"
	einfo "Then stick it into ${DISTDIR}"
}

src_prepare() {
	local PATCHES=(
		"${FILESDIR}/${P}-driver-irq-flag.patch"
		"${FILESDIR}/${P}-driver-build.patch"
	)

	default

	if use utils; then
		epatch "${FILESDIR}/${P}-utility-build.patch"
		epatch "${FILESDIR}/${P}-utility-implicit-decl.patch"
	fi
}

src_compile() {
	linux-mod_src_compile

	if use utils; then
		cd ${S}/utility
		emake || die "emake failed"
	fi
}

src_install() {
	linux-mod_src_install

	if use utils; then
		cd ${S}/utility
		emake DESTDIR="${D}" install || die "install failed"
	fi

	local rules="${FILESDIR}/99-mxser.rules"
	udev_newrules ${rules} 99-${PN}.rules
}

pkg_postinst() {
	linux-mod_pkg_postinst
	elog "If you are using sys-apps/openrc, please add \"mxser\" or \"mxupcie\" to:"
	elog "	/etc/conf.d/modules"
}
