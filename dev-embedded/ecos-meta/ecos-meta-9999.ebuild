# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

DESCRIPTION="""An open source, royalty-free, real-time operating system intended for
			embedded applications."""
HOMEPAGE="http://ecos.sourceware.org/"
SRC_URI=""

LICENSE="metapackage"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="~dev-embedded/ecos-infra-${PV}
		~dev-embedded/ecos-libcdl-${PV}
		~dev-embedded/ecos-packages-${PV}"
RDEPEND="${DEPEND}"
