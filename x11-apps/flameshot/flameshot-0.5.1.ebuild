# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit qmake-utils

DESCRIPTION="Powerful yet simple to use screenshot software"
HOMEPAGE="https://github.com/lupoDharkael/flameshot"
SRC_URI="https://github.com/lupoDharkael/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtdbus:5
	dev-qt/qtwidgets:5
	dev-qt/linguist-tools:5
"
RDEPEND="${DEPEND}"


src_configure() {
	eqmake5 CONFIG+=packaging
}


src_install() {
	emake INSTALL_ROOT="${D}" install
}
