# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Core Python libraries ported to MicroPython"
HOMEPAGE="https://github.com/micropython/micropython-lib"
SRC_URI="https://github.com/micropython/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_install() {
	emake PREFIX="${D}"/usr/lib/micropython install

	einstalldocs
}
