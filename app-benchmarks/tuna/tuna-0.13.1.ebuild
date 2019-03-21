# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="Application tuning GUI & command line utility"
HOMEPAGE="http://git.kernel.org/cgit/utils/tuna/tuna.git/
	https://www.kernel.org/pub/software/utils/tuna/"
SRC_URI="https://www.kernel.org/pub/software/utils/tuna/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

DEPEND="
	dev-python/python-ethtool
	>=dev-python/python-linux-procfs-0.4.5
	>=dev-python/python-schedutils-0.2"
RDEPEND="${DEPEND}"

python_install_all() {
	DOCS+=( ChangeLog )
	use doc && DOCS+=( docs/oscilloscope+tuna.pdf )
	use doc && HTML_DOCS+=( docs/oscilloscope+tuna.html )

	distutils-r1_python_install_all

	# man-pages
	doman docs/tuna.8

	# executables
	exeinto "/usr/bin"
	newexe tuna-cmd.py tuna
	newexe oscilloscope-cmd.py oscilloscope

	# misc
	insinto "/usr/share/${PN}"
	doins tuna/tuna_gui.glade
	insinto "/usr/share/${PN}/help/kthreads"
	doins help/kthreads/*
	insinto "/usr/share/${PN}/polkit-1/actions"
	doins org.tuna.policy
	insinto "/etc/${PN}"
	doins etc/tuna/example.conf
	insinto "/etc"
	doins etc/tuna.conf
}
