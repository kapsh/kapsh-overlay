# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
inherit font

DESCRIPTION="Fonts supplied with Windows Vista"
LONG_DESCRIPTION="ClearType Font Collection, a suite of fonts released with Windows Vista
and Microsoft Office 2007: Calibri, Cambria, Candara, Consolas, Constantia, Corbel"

RESTRICT="mirror"

HOMEPAGE="https://www.microsoft.com/en-us/download/confirmation.aspx?id=13"
SRC_URI="http://download.microsoft.com/download/E/6/7/E675FFFC-2A6D-4AB0-B3EB-27C9F8C8F696/PowerPointViewer.exe"

LICENSE="MSttfEULA"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-arch/cabextract"
RDEPEND="${DEPEND}"

S="${WORKDIR}"
FONT_S="${WORKDIR}"
FONT_SUFFIX="ttf"

src_unpack() {
	cabextract -F "ppviewer.cab" "${DISTDIR}/PowerPointViewer.exe"
	cabextract -L -F "*.ttf" "ppviewer.cab"
}

src_install() {
	font_src_install
}
