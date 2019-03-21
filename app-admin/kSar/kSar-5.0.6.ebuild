# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils unpacker

DESCRIPTION="Ksar is a sar graphing tool that can graph sar output."
HOMEPAGE="https://sourceforge.net/projects/ksar/"
SRC_URI="mirror://sourceforge/ksar/${P}.zip"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=virtual/jre-1.7.0
		app-arch/unzip"
RDEPEND="${DEPEND}"

INSTDIR="/opt/${PN}/${PV}"

src_install() {
	insinto "${INSTDIR}"
	doins -r ${WORKDIR}/${P}/*
	dodoc -r ${WORKDIR}/${P}/docs/
	cp -v "${FILESDIR}"/kSar ${WORKDIR} || die

	sed -i "s:VER:${PV}:" "${WORKDIR}"/kSar || die
	dobin "${WORKDIR}"/kSar

	#TODO add some shortcut to windowmanager
}
