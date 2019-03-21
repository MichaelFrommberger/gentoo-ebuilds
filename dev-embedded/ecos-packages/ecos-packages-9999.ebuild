# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit mercurial

DESCRIPTION="""An open source, royalty-free, real-time operating system intended for
			embedded applications."""
HOMEPAGE="http://ecos.sourceware.org/"
EHG_REPO_URI="http://hg-pub.ecoscentric.com/ecos/"
EHG_PROJECT="ecos"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc"

DEPEND="doc? (
				>=app-text/docbook-sgml-dtd-3.1-r4
				app-text/docbook-sgml
			)"
RDEPEND="${DEPEND}"

S="${WORKDIR}/ecos-${PV}"
BUILD_DIR="${WORKDIR}/${P}_build"
DOC_DIR_BUILD="${BUILD_DIR}/doc"

src_configure() {
	return
}

src_compile() {
	if use doc; then
		local DOC_DIR="${S}/doc/sgml"

		mkdir -p ${DOC_DIR_BUILD}
		cd ${DOC_DIR_BUILD}
		${DOC_DIR}/makemakefile
		make html
	fi
}

src_install() {
	insinto /usr/share/ecos-${PV}
	cp -dpR packages "${D}/usr/share/ecos-${PV}/"

	dodoc packages/ChangeLog packages/NEWS

	if use doc; then
		dohtml -r ${DOC_DIR_BUILD} || die "dohtml failed" 
	fi
}
