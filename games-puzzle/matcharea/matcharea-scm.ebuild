# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit games git-r3 qmake-utils font

DESCRIPTION="Attention training game"
HOMEPAGE="https://github.com/drafterleo/matcharea"
SRC_URI=""

EGIT_REPO_URI="https://github.com/drafterleo/matcharea.git"

LICENSE=""
SLOT="0"
IUSE=""

if [ "${PV}" = "scm" ]; then
	KEYWORDS=""
	EGIT_BRANCH="master"
else
	KEYWORDS="~amd64 ~x86"
	EGIT_COMMIT="1b1227c"
fi

DEPEND=""
RDEPEND="${DEPEND}
	dev-qt/qtgui:4"

FONT_SUFFIX="ttf"
FONT_S="${S}/PsyMatchArea/fonts"

src_compile() {
	cd "${S}/PsyMatchArea"
	eqmake4 "PsyMatchArea.pro"
	emake
}

src_install() {
	dogamesbin "${S}/PsyMatchArea/PsyMatchArea"
	doicon "${S}/PsyMatchArea/images/PsyMatchAreaIcon.png"
	font_src_install
	make_desktop_entry "PsyMatchArea" "PsyMatchArea" "PsyMatchAreaIcon"
}

