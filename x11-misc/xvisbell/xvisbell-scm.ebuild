# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit git-r3

DESCRIPTION="simple program that flashes a white bar on the screen whenever the X11 bell is rung"
HOMEPAGE="https://github.com/rianhunter/xvisbell"
SRC_URI=""
EGIT_REPO_URI="https://github.com/rianhunter/xvisbell.git"

if [ "${PV}" = "scm" ]; then
	EGIT_BRANCH="master"
	KEYWORDS=""
else
	EGIT_COMMIT="10674328"
	KEYWORDS="~x86 ~amd64"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}/my-settings.patch"
}

src_install() {
	dobin "${S}/xvisbell"
}
