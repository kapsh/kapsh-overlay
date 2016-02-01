# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit vim-plugin git-r3

DESCRIPTION="vim plugin: Vim bundle, a vim plugin manager"
HOMEPAGE="http://github.com/gmarik/vundle"
EGIT_REPO_URI="git://github.com/VundleVim/Vundle.vim.git"
LICENSE="MIT"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="${RDEPEND}
dev-vcs/git"

VIM_PLUGIN_HELPFILES="vundle.txt"
VIM_PLUGIN_HELPTEXT=""
VIM_PLUGIN_HELPURI=""
VIM_PLUGIN_MESSAGES=""

src_prepare () { 
	rm -rf test
}
