# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils mono mono-env

DESCRIPTION="XSD Diagram is a free xml schema definition diagram viewer"
HOMEPAGE="http://regis.cosnier.free.fr)."
SRC_URI="https://github.com/dgis/xsddiagram/archive/${PN}_${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-lang/mono"
RDEPEND="${DEPEND}"

BUILD_DIR="${S}/xsddiagram-${PN}_${PV}"
OUT_DIR="${BUILD_DIR}/bin/Release"
INST_DIR="/opt/${PN}/bin"

src_unpack(){
	mkdir -p "${S}" || ide
	cd "${S}"
	unpack ${A}
}

src_prepare(){
	cd "${BUILD_DIR}"

	local PATCHES=(
		"${FILESDIR}/${P}-use-system-renderer.patch"
	)

	default
}

src_compile() {
	cd "${BUILD_DIR}"
	xbuild /p:Configuration=Release XSDDiagram2010.csproj
}

src_install() {
	# prepare script to start XSDDiagram
	cp -v "${FILESDIR}"/XSDDiagram ${OUT_DIR} || die
	sed -i -e "s:XSD_DIAGRAM:${INST_DIR}/${PN}.exe:" ${OUT_DIR}/XSDDiagram || die

	insinto "${INST_DIR}"
	doins "${OUT_DIR}/${PN}.exe"
	doins "${OUT_DIR}/${PN}s.dll"
	dobin "${OUT_DIR}/${PN}"
	dodoc "${BUILD_DIR}/ReadMe.txt"

	newicon ${BUILD_DIR}/Icons/${PN}.png ${PN}.png
	make_desktop_entry "${PN}" "${PN}" "${PN}" "Development;IDE;Documentation;"


}
