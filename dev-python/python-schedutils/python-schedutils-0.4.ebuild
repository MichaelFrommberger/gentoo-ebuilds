# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="Python interface for the Linux scheduler functions etc."
HOMEPAGE="https://www.kernel.org/pub/software/libs/python/python-schedutils/
	https://kernel.googlesource.com/pub/scm/libs/python/python-schedutils/python-schedutils/"
SRC_URI="https://www.kernel.org/pub/software/libs/python/python-schedutils/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
