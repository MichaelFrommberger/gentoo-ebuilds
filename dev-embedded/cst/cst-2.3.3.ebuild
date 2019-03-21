# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils

DESCRIPTION="To generate output binary CSF using Code Signing Tool."
HOMEPAGE="https://www.nxp.com/"
SRC_URI="cst-2.3.3.tar.gz"

LICENSE="|| ( openssl SSLeay nxp ) Freescale License"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

# No need for stripping
RESTRICT="fetch strip"
DEPEND=""
RDEPEND="${DEPEND}"

pkg_nofetch() {
	# Will be run case the source file was not found
	einfo "Please visit this URL to download the package:"
	einfo "${HOMEPAGE}"
	einfo "Then copy it into local distfiles (portage)"
}


#src_prepare() {
#	 epatch "${FILESDIR}/hab4_pki_tree.sh.patch"
#	eapply_user
#}

INSTDIR="/opt/${PN}"

src_install() {
	insinto /opt/${PN}
	touch ${WORKDIR}/${P}/keys/key_pass.txt

	doins -r "${S}"/*
	fperms 777 /opt/${PN}/keys/key_pass.txt
	fperms +x "/opt/${PN}/keys/hab4_pki_tree.sh"
	fperms -R 755 "/opt/${PN}/linux64/bin"

	echo -n "PATH=/opt/cst/linux64/bin" > ${T}/99cst
	doenvd "${T}/99cst" 
	#doenvd "${FILESDIR}/99cst"  # @todo: Replace this by an echo
}
