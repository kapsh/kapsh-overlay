# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit gnome2-utils xdg

DESCRIPTION="Intelligent Python IDE with unique code assistance and analysis"
HOMEPAGE="http://www.jetbrains.com/pycharm/"
SRC_URI="http://download.jetbrains.com/python/${P}.tar.gz"

LICENSE="Apache-2.0 BSD CDDL MIT-with-advertising"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="system-jre"

RDEPEND="
	system-jre? ( >=virtual/jre-1.8 )
"
DEPEND=""

RESTRICT="mirror strip"

QA_PREBUILT="
	opt/${PN}/bin/fsnotifier
	opt/${PN}/bin/fsnotifier64
	opt/${PN}/bin/fsnotifier-arm
"

EXECUTABLES=(
	format.sh
	fsnotifier{,64}
	inspect.sh
	printenv.py
	pycharm.sh
	restart.py
)

PRODUCT=${PN/-community/}


src_prepare() {
	default

	if use system-jre; then
		rm -rf ${S}/jre64 || die
	fi
}


src_install() {
	insinto /opt/${PN}
	doins -r *

	for exe in ${EXECUTABLES[@]}; do
		fperms a+x /opt/${PN}/bin/${exe}
	done

	if use !system-jre; then
		fperms a+x /opt/${PN}/jre64/bin/*
	fi

	dodir /usr/bin
	dosym ../../opt/${PN}/bin/pycharm.sh /usr/bin/${PN}
	newicon bin/${PRODUCT}.png ${PN}.png
	make_desktop_entry ${PN} ${PN} ${PN}
}


pkg_postinst() {
	xdg_pkg_postinst
	gnome2_icon_cache_update
}


pkg_postrm() {
	xdg_pkg_postrm
	gnome2_icon_cache_update
}
