# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit eutils unpacker

DESCRIPTION="""Cross-compile toolchain for arm microcontroller (e.g. armStone) from
			F&S Elektronik Systeme GmbH."""
HOMEPAGE="https://fs-net.de"
FS_NAME="${P}-cortexa5-neonvfpv4"
SRC_URI="${FS_NAME}.tar.bz2"

LICENSE="FS"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
RESTRICT="fetch strip"

DEPEND=""
RDEPEND="${DEPEND}"

pkg_nofetch() {
	einfo "Please visit this URL to download the package:"
	einfo "${HOMEPAGE}"
	einfo "Then stick it into ${DISTDIR}"
}

src_unpack() {
	mkdir -p "${S}"
	cd "${S}"
	unpack ${A}
}

src_configure() { :; }

src_compile() { :; }

src_install() {
	local inst_loc=/usr/local/arm
	dodir ${inst_loc}
	cp -R "${S}/${FS_NAME}" "${D}${inst_loc}" || die "Install failed!"

	local inst_dir=${inst_loc}/${FS_NAME}
	echo -n "PATH=\$PATH\:${inst_loc}/${FS_NAME}/bin" > "${T}/99fs-toolchain"
	doenvd "${T}/99fs-toolchain"
}
