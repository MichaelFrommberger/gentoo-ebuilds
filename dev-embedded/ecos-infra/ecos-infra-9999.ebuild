# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils autotools-utils mercurial

DESCRIPTION="""An open source, royalty-free, real-time operating system intended for 
			embedded applications."""
HOMEPAGE="http://ecos.sourceware.org/"
EHG_REPO_URI="http://hg-pub.ecoscentric.com/ecos/"
EHG_PROJECT="ecos"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="debug unicode"

DEPEND=""
RDEPEND="${DEPEND}"

PRJ_DIR=host/infra
ECONF_SOURCE=${S}/${PRJ_DIR}
DOCS=(README.host ${PRJ_DIR}/ChangeLog)

src_configure() {
	local myeconfargs=(
		$(use_enable debug)
		$(use_enable !unicode ansi)
	)
	autotools-utils_src_configure
}

src_compile() {
	autotools-utils_src_compile -j1
}

src_install() {
	autotools-utils_src_install -j1
}
