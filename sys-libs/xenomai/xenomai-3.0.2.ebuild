# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

DESCRIPTION="Xenomai is a real-time development framework cooperating with the Linux kernel"
HOMEPAGE="http://www.xenomai.org"
SRC_URI="https://xenomai.org/downloads/xenomai/stable/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="debug mercury assert pshared tls smp doc"

DEPEND=">=sys-kernel/xenomai-sources-4.1.18
		doc? (
				app-text/asciidoc
				media-gfx/graphviz
				app-doc/doxygen
			)"
RDEPEND="${DEPEND}"

# On purpose, this ebuild does not use econf, emake or einstall.  The
# good reason: these specify --prefix=/usr without any way to
# override.  However, this ebuild allows Xenomai to apply its default
# prefix of /usr/xenomai.  Therefore it compiles and installs using the
# usual sequence of
#
#	./configure
#	make
#	make DESTDIR=image install

src_configure() {
	# Pass the Linux kernel directory. Do not let the configure
	# script guess; it might guess incorrectly if, for example, the
	# build and target hosts do no run the same kernel. Passing
	# KERNEL_DIR lets you override if necessary by setting
	# KERNEL_DIR=some-kernel-source-path in a prefix to emerge!
	if [ -n "${KERNEL_DIR}" ]
		then KERNEL_DIR="/usr/src/linux-4.1.18-xenomai"
	fi

	# defaults to cobalt core
	local CORE="cobalt"
	if use mercury; then
		CORE="mercury"
	fi

	local DOC_BUILD=""
	if use doc; then
		DOC_BUILD="--enable-doc-build"
	fi

	./configure --enable-linux-build=${KERNEL_DIR} \
		--with-core=${CORE} \
		$(use_enable debug) \
		$(use_enable assert) \
		$(use_enable pshared) \
		$(use_enable tls) \
		$(use_enable smp) \
		${DOC_BUILD} \
		${myconf} || die "configure failed"
}
