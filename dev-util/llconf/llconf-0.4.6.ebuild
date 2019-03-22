# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils

DESCRIPTION=""
HOMEPAGE="https://code.google.com/archive/p/llconf/"
SRC_URI="https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/llconf/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}/${P}-long-lines.patch"
	epatch "${FILESDIR}/${P}-perffix-unparse.patch"
}
