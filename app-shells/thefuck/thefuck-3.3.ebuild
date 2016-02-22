# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python{2_7,3_5} )

inherit distutils-r1

DESCRIPTION="Magnificent app which corrects your previous console command"
HOMEPAGE="https://github.com/nvbn/thefuck"
SRC_URI="https://github.com/nvbn/thefuck/archive/${PV}.tar.gz -> thefuck-${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=">=dev-python/setuptools-17.1"
RDEPEND="${DEPEND}
	dev-python/psutil
	dev-python/colorama
	dev-python/six
	dev-python/decorator"

src_prepare() {
	# For some reason setup.py installs tests too
	# which is forbidden by distutils-r1
	rm -r "${S}/tests"
}

pkg_postinst() {
	einfo 'To configure "fuck" alias add to .bashrc/.zshrc line'
	einfo '"eval $(thefuck --alias)"'
}
