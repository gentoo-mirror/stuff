# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit kde4-base mercurial

DESCRIPTION="KDE Dolphin plugin for Dropbox (from Mercurial repos)"
HOMEPAGE="https://bitbucket.org/cancel/dolphin-dropbox-plugin"
SRC_URI=""
EHG_REPO_URI="https://bitbucket.org/cancel/dolphin-dropbox-plugin"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~*"
IUSE="debug"

DEPEND="$(add_kdebase_dep dolphin)"

RDEPEND="${DEPEND}
	!kde-base/dolphin-box-plugin"
