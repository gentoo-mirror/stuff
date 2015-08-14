# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils autotools git-2

DESCRIPTION="MPRIS-plugin for deadbeef"
HOMEPAGE="https://github.com/Jerry-Ma/DeaDBeeF-MPRIS-plugin"
EGIT_REPO_URI="git://github.com/Jerry-Ma/DeaDBeeF-MPRIS-plugin.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND_COMMON="media-sound/deadbeef"

RDEPEND="${DEPEND_COMMON}"
DEPEND="${DEPEND_COMMON}"

src_prepare(){
	eautoreconf
}

src_configure(){
	econf \
		--enable-static=no \
		--enable-shared=yes \
		--disable-dependency-tracking
}
