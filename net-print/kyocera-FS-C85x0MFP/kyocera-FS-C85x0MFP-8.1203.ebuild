# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

DESCRIPTION="""PPD description files for Kyocera FS-C85x0MFP
			Printers (FS-C8520MFP, FS-C8525MFP)"""
HOMEPAGE="http://www.kyoceradocumentsolutions.de"
SRC_URI="LinuxDrv_${PV}...FS-C85x0MFP.zip"

LICENSE="kyocera-ppds"
SLOT="0"
KEYWORDS="~amd64"
IUSE_LINGUAS="en fr de it pt es"

IUSE=""
for lingua in $IUSE_LINGUAS; do
	IUSE="${IUSE} linguas_$lingua"
done

RDEPEND="net-print/cups"
DEPEND="app-arch/unzip"

S="${WORKDIR}/driver"

RESTRICT="fetch"

pkg_nofetch() {
	einfo "Please download ${A} from the following URL:"
	einfo "http://www.kyoceradocumentsolutions.de/index/serviceworld/downloadcenter.false.driver.FSC8525MFP._.DE.html"
}

src_compile() { :; }

src_install() {
	insinto /usr/share/cups/model/Kyocera-FS-C85x0MFP

	local installall=yes
	for lingua in $IUSE_LINGUAS; do
		if use linguas_$lingua; then
			installall=no
			break;
		fi
	done

	inslanguage() {
		if [[ ${installall} == yes ]] || use linguas_$1; then
			doins $2/*.ppd || die "failed to install $2 ppds"
		fi
	}

	inslanguage en English
	inslanguage fr French
	inslanguage de German
	inslanguage it Italian
	inslanguage pt Portuguese
	inslanguage es Spanish

	dohtml ${WORKDIR}/ReadMe.htm || die
}
