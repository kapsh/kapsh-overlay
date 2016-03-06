# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

DESCRIPTION="Adds kernel codename to /etc/issue"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}"

src_install() {
	dobin "${FILESDIR}/kernel-codename"
	doinitd "${FILESDIR}/issue-codename"
	insinto "/etc"
	doins "${FILESDIR}/issue.template"
}

pkg_postinst() {
	einfo "Run \"rc-update add issue-codename\""
}
