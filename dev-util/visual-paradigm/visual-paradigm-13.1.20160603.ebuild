# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit versionator eutils

MY_PN="Visual_Paradigm"
MY_P="${MY_PN}_$(get_version_component_range 1-2)"
MY_PV="$(replace_all_version_separators _)"
SRC_URI_FORMAT="http://%s.visual-paradigm.com/visual-paradigm/vp$(get_version_component_range 1-2)/$(get_version_component_range 3)/${MY_PN}_${MY_PV}_Linux64_InstallFree.tar.gz"

DESCRIPTION="Visual Paradigm for UML"
HOMEPAGE="http://www.visual-paradigm.com"

SRC_URI=`printf "${SRC_URI_FORMAT} " eu{1..4} usa{5..6}`

S="${WORKDIR}/${MY_P}"

LICENSE="as-is" # actually, proprietary
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RESTRICT="mirror"

DEPEND=""
RDEPEND=">=virtual/jre-1.5
	x11-misc/xdg-utils
	sys-auth/polkit"

INSTDIR="/opt/Visual-Paradigm/${MY_PN}"

src_compile() {
	rm Application/bin/Visual_Paradigm_Update || die

	sed -i -e '2i INSTALL4J_JAVA_HOME_OVERRIDE=$JAVA_HOME' \
		Application/bin/Visual_Paradigm* || die
}

src_install() {
	insinto "${INSTDIR}"
	doins -r Application .install4j

	rm "${D}${INSTDIR}"/.install4j/firstrun

	chmod +x "${D}${INSTDIR}"/Application/bin/*
	dodoc -r Application/samples

	make_desktop_entry "${INSTDIR}"/Application/bin/${MY_PN} "Visual Paradigm" "${INSTDIR}"/Application/resources/vpuml.png

	dodir /etc/env.d
	cat - > "${D}"/etc/env.d/99visualparadigm <<EOF
CONFIG_PROTECT="${INSTDIR}/resources/product_edition.properties"
EOF
}
