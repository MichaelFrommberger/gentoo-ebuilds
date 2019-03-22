# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"
ETYPE="sources"
KEYWORDS="~amd64"

HOMEPAGE="http://www.xenomai.org/"

inherit versionator

CKV="$(get_version_component_range 1-3)"
K_SECURITY_UNSUPPORTED="yes"
K_DEBLOB_AVAILABLE="1"

inherit kernel-2
detect_version

K_BRANCH_ID="${KV_MAJOR}.${KV_MINOR}"
# Xenomai 3.0.2
XENO_VER_MAJOR="3"
XENO_VER_MINOR="0"
XENO_REV_LEVEL="2"
XENO_VER_STRING="${XENO_VER_MAJOR}.${XENO_VER_MINOR}.${XENO_REV_LEVEL}"
XENO_SRC="xenomai-${XENO_VER_STRING}"
XENO_TAR="${XENO_SRC}.tar.bz2"
XENO_URI="https://xenomai.org/downloads/xenomai/stable/${XENO_TAR}"

DESCRIPTION="""Full Linux ${K_BRANCH_ID} kernel sources with Xenomai
			${XENO_VER_STRING} Cobalt kernel side-by-side."""
SRC_URI="${KERNEL_URI} ${XENO_URI}"

UNIPATCH_LIST="${DISTDIR}/${RT_FILE}"
UNIPATCH_STRICTORDER="yes"

src_unpack() {
	kernel-2_src_unpack

	# Portage's ``unpack'' macro unpacks to the current directory.
	# Unpack to the work directory.  Afterwards, ``work'' contains:
	#	linux-4.1.18-xenomai
	#	xenomai-3.0.2
	cd ${WORKDIR}
	unpack ${XENO_TAR} || die "unpack failed"
	cd ${WORKDIR}/${XENO_SRC}
	epatch ${FILESDIR}/prepare-kernel.patch || die "patch failed"

	scripts/prepare-kernel.sh --linux=${S} --default || die "prepare kernel failed"
}

