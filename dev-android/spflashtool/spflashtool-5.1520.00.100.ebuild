# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

DESCRIPTION="SmartPhone Flash Tool for MTK based Android devices"
HOMEPAGE="http://spflashtool.com/"
SRC_URI="
	x86? ( http://spflashtool.com/download/SP_Flash_Tool_Linux_32Bit_v${PV}.zip )
	amd64? ( http://spflashtool.com/download/SP_Flash_Tool_exe_Linux_64Bit_v${PV}.zip )
	udev-rules? ( https://github.com/M0Rf30/android-udev-rules/raw/master/51-android.rules )"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"
IUSE="+udev-rules +system-qt"

DEPEND=""
RDEPEND="${DEPEND}
	system-qt? (
		dev-qt/qtgui:4
		dev-qt/qtwebkit:4
		dev-qt/qthelp:4
	)
	sys-apps/util-linux
	app-arch/bzip2"

S="${WORKDIR}/SP_Flash_Tool_exe_Linux_v5.1520.00.100"

src_prepare() {
	if use system-qt; then
		# Remove packaged version of Qt libs
		rm "${S}/lib" -rf
	fi
}

src_install() {
	if use udev-rules; then
		insinto /lib/udev/rules.d/
		doins "${DISTDIR}/51-android.rules"
	fi
	local dest=/opt/${PN}
	dodir ${dest}
	insinto ${dest}
	insopts -m 0644
	doins *
	fperms 755 ${dest}/flash_tool
	newbin ${FILESDIR}/launcher.sh spflashtool
}

pkg_postinst(){
	ewarn "After installation of udev run:"
	ewarn "# udevadm control --reload-rules"

}
