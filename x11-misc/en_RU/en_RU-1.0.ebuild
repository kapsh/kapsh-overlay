# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

DESCRIPTION="English Language Locale for Russia"
HOMEPAGE="http://catap.ru/blog/2009/09/03/en_ru-install-to-your-system/"
SRC_URI="http://catap.ru/stuff/en_RU"

LICENSE="freedist"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

RESTRICT="mirror"

S=${WORKDIR}

src_install() {
	insinto /usr/share/i18n/locales
	doins ${DISTDIR}/en_RU
}

pkg_postinst(){
	local enru="en_RU.UTF-8 UTF-8"
	grep "${enru}" /usr/share/i18n/SUPPORTED || echo ${enru} >> /usr/share/i18n/SUPPORTED
	grep "${enru}" /etc/locale.gen || echo ${enru} >> /etc/locale.gen
	locale-gen
	eselect locale set en_RU.UTF-8
	einfo "en_RU locale is installed and activated"
}
