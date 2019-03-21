# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils unpacker

DESCRIPTION="""STM32CubeMX is a graphical tool that allows configuring STM32 microcontrollers very easily and
			generating the corresponding initialization C code through a step-by-step process."""
HOMEPAGE="http://www.st.com/web/catalog/tools/FM147/CL1794/SC961/SS1743/PF259242"
SRC_URI="stm32cubemx.zip"

LICENSE="STM"
SLOT="0"
KEYWORDS="~amd64"
IUSE="imagemagick"
RESTRICT="fetch strip"

DEPEND=">=virtual/jre-1.7.0
		imagemagick? ( media-gfx/imagemagick )"
RDEPEND="${DEPEND}"

pkg_nofetch() {
	einfo "Please visit this URL to download the package:"
	einfo "${HOMEPAGE}"
	einfo "Then stick it into ${DISTDIR}"
}

src_unpack() {
	mkdir -p "${S}"
	cd "${S}"
	unpack ${A}
}

src_prepare() {
	cp "${FILESDIR}"/${P}-auto-install.xml "${S}" || die
	sed -i "s:ED:${ED}:" ${P}-auto-install.xml || die
}
src_configure() { :; }

src_compile() { :; }

src_install() {
	./SetupSTM32CubeMX-${PV}.linux -console ${P}-auto-install.xml >/dev/null 2>&1

	# remove uninstaller (we want portage to take track of installed stuff)
	find ${D} -name "Uninstaller" | xargs rm -r

	local cubemx_bin=STM32CubeMX
	dobin "${FILESDIR}"/${PN}

	# convert windows icons and register with desktop
	if use imagemagick; then
		find ${D} -name "*.ico" | xargs -I % convert % %.png
		local cubemx_icon="${D}opt/STMicroelectronics/STM32Cube/STM32CubeMX/help/STM32CubeMX.ico.png"
		newicon ${cubemx_icon} STM32CubeMX.png && rm ${cubemx_icon}
		make_desktop_entry "${cubemx_bin}" "STM32CubeMX" "STM32CubeMX" "Development;IDE;Java;" "Terminal=false"
	fi

	# remove windows icons
	find ${D} -name "*.ico" | xargs rm
}
