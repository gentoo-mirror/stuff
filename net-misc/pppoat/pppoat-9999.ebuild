# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

EGIT_REPO_URI="https://github.com/pasis/pppoat.git"

inherit autotools eutils git-r3

DESCRIPTION="PPP over Any Transport"
HOMEPAGE="https://github.com/pasis/pppoat"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE="+xmpp"

RDEPEND="xmpp? ( dev-libs/libstrophe )"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${P/-/_}"

src_prepare() {
		eautoreconf
}

src_configure() {
		econf $(use_enable xmpp)
}
