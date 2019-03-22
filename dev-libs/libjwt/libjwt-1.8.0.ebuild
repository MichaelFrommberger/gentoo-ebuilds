# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools

DESCRIPTION="A JWT C Library"
HOMEPAGE="https://github.com/benmcollins/libjwt"
SRC_URI="https://github.com/benmcollins/libjwt/archive/v${PV}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	dev-libs/jansson
	dev-libs/openssl"
RDEPEND="${DEPEND}"

src_prepare() {
	eapply_user
	eautoreconf
}


