# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit multilib autotools-utils mercurial

DESCRIPTION="""An open source, royalty-free, real-time operating system intended for 
			embedded applications."""
HOMEPAGE="http://ecos.sourceware.org/"
EHG_REPO_URI="http://hg-pub.ecoscentric.com/ecos/"
EHG_PROJECT="ecos"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="debug unicode doc"

DEPEND="~dev-embedded/ecos-infra-${PV}
		dev-lang/tcl
		dev-lang/tk
		doc? (
				media-gfx/xfig
				app-text/docbook-sgml
			)"
RDEPEND="${DEPEND}"

PRJ_DIR=host/libcdl
ECONF_SOURCE=${S}/${PRJ_DIR}
DOCS=(README.host ${PRJ_DIR}/ChangeLog ${PRJ_DIR}/TODO)

src_configure() {
	local myeconfargs=(
		--with-infra-header=/usr/include \
		--with-infra-lib=/usr/$(get_libdir) \
		$(use_enable debug)
		$(use_enable !unicode ansi)
	)
	autotools-utils_src_configure
}

src_compile() {
	autotools-utils_src_compile
	if use doc; then
		local DOC_DIR="${S}/${PRJ_DIR}/doc"
		local DOC_DIR_BUILD="${BUILD_DIR}/doc"
		HTML_DOCS=${DOC_DIR_BUILD}

		mkdir -p ${DOC_DIR_BUILD}
		emake -f "${DOC_DIR}/makefile" -C ${DOC_DIR_BUILD} html TOPLEVEL="${S}/packages" VPATH=${DOC_DIR}
	fi
}

src_install() {
	autotools-utils_src_install
}
