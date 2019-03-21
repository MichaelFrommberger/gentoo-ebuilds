# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit flag-o-matic multiprocessing

DESCRIPTION="Cross-compile toolchain for PC (x86 64 bit) from Diehl Metering Detschland GmbH."
HOMEPAGE="http://www.diehl.com/de/diehl-metering/diehl-metering.html"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="strip"

DEPEND="sys-devel/ct-ng"
RDEPEND="${DEPEND}"

src_unpack() {
	# create workdir
	mkdir -p "${S}" || die
	# copy ct-ng configuration to workdir
	cp -v "${FILESDIR}"/dm-config-x86_64-${PV} ${S}/.config || die

	cd "${S}"
}

src_prepare() {
	# replace download path with distfiles and makde it writable
	sed -i -e "s:.*CT_LOCAL_TARBALLS_DIR=.*:CT_LOCAL_TARBALLS_DIR=\"${PORTDIR}/distfiles\":" ${S}/.config || die
	addwrite ${PORTDIR}/distfiles

	# replace installation path with temporary install directory
	sed -i -e "s:.*CT_PREFIX_DIR=\":CT_PREFIX_DIR=\"${T}/install:" ${S}/.config || die

	# set number of jobs from emerge
	sed -i -e "s:.*CT_PARALLEL_JOBS=0:CT_PARALLEL_JOBS=$(makeopts_jobs):" ${S}/.config || die

	# set average load from emerge
	sed -i -e "s:.*CT_LOAD=\"\":CT_LOAD=\"$(makeopts_loadavg)\":" ${S}/.config || die

	eapply_user
}

src_configure() {
	# use supplied config to build toolchain
	ct-ng oldconfig
}

src_compile() {
	cd "${S}"
	einfo "Downloading sources"
	CFLAGS="" CXXFLAGS="" LDFLAGS="" ABI="" ct-ng source || die
	echo ""
	einfo "Building toolchain"
	CFLAGS="" CXXFLAGS="" LDFLAGS="" ABI="" ct-ng build || die
}

src_install() {
	local inst_dir=$(sed -n "s:CT_PREFIX_DIR=::p" ${FILESDIR}/dm-config-x86_64-${PV} | sed 's:["",]::g')

	# cp from temporary install dir to "real" install dir 
	cp -R ${T}/install/* "${D}" || die "Install failed!"

	echo -n "PATH=${inst_dir}/bin" > "${T}/99dm-toolchain-x86_64"
	doenvd "${T}/99dm-toolchain-x86_64"
}
