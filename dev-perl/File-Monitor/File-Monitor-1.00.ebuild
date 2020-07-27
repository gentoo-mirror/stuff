# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

MODULE_AUTHOR=ANDYA
MODULE_VERSION=${PV}
inherit perl-module

DESCRIPTION="Monitor files and directories for changes"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RDEPEND="
	dev-perl/Module-Build
"

DEPEND="${RDEPEND}"

SRC_TEST=do
