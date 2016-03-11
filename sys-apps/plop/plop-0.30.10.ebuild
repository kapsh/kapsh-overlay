# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils bash-completion-r1

DESCRIPTION="A nice paludis.log parser (patched genlop)"
HOMEPAGE="http://www.genoetigt.de/site/projects/plop"
# Let's start from original genlop sources
SRC_URI="https://dev.gentoo.org/~dilfridge/distfiles/genlop-${PV}.tar.gz"
RESTRICT="primaryuri"

LICENSE="GPL-2+insecure"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc x86 ~x86-fbsd"
IUSE="bash-completion zsh-completion"

DEPEND=">=dev-lang/perl-5.8.0-r12
	 >=dev-perl/Date-Manip-5.40
	 dev-perl/libwww-perl"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	mv  "${WORKDIR}"/genlop-${PV}/ "${S}"
	cd "${S}"
	mv genlop plop
	mv genlop.1 plop.1
	mv genlop.bash-completion plop.bash-completion
	epatch "${FILESDIR}"/"${P}".patch
}

src_install() {
	dobin plop || die "failed to install plop (via dobin)"
	dodoc README Changelog
	doman plop.1
	if use bash-completion; then
		dobashcomp plop.bash-completion plop
	fi
	if use zsh-completion; then
		insinto /usr/share/zsh/site-functions
		newins "${FILESDIR}"/zsh-completion _plop
	fi
}

pkg_postinst() {
	einfo "Note that plop is just a patched genlop-0.30.8. I only patched the"
	einfo "main script. The manpage, README, etc. are all original genlop"
	einfo "files, but since plop is expected to work like genlop this"
	einfo "shouldn't be a problem. so if you find see genlop somewhere, simply"
	einfo "substitute it with plop, as long as it hasn't to do anything with"
	einfo "copyright or other credits"

	einfo "to convert old emerge.logfiles I've written a small perlscript that"
	einfo "you can download on the plop homepage"
}
