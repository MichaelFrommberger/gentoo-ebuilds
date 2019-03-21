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
IUSE="debug unicode"


DEPEND="~dev-embedded/ecos-infra-${PV}
		~dev-embedded/ecos-libcdl-${PV}
		dev-lang/tcl
		dev-lang/tk"
RDEPEND="${DEPEND}"

PRJ_DIR=host/tools/configtool/standalone/common
ECONF_SOURCE=${S}/${PRJ_DIR}
DOCS=(README.host ${PRJ_DIR}/ChangeLog)

src_configure() {
	local myeconfargs=(
		--with-infra-header=/usr/include \
		--with-infra-lib=/usr/$(get_libdir) \
		--with-libcdl-header=/usr/include \
		--with-libcdl-lib=/usr/$(get_libdir) \
		$(use_enable debug)
		$(use_enable !unicode ansi)
	)
	autotools-utils_src_configure
}

src_compile() {
	autotools-utils_src_compile

#	compiling gui doesn't work yet
# 
#	local BUILD_DIR_WX=${WORKDIR}/${P}_build_wx
#	local SOURCE_WX=${S}/host/tools/configtool/standalone/wxwin
#
#	 mkdir -p ${BUILD_DIR_WX}
#	cd "${BUILD_DIR_WX}"
#	# disable unicode: -DwxUSE_UNICODE=0
#	emake -j 1 -f "${SOURCE_WX}/makefile.gnu" WXDIR=/usr ECOSSRCDIR="${S}/host" INSTALLDIR="${WORKDIR}/ecos-${PV}/tools" OSTYPE=linux-gnu CPPFLAGS="`wx-config --cppflags` -DwxUSE_UNICODE=0" || die "emake wxgui failed"

}

src_install() {
	autotools-utils_src_install
}
