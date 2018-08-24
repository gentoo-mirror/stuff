# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

#E_PKG_IUSE="nls"
EFL_USE_GIT="yes"
EFL_GIT_REPO_CATEGORY="enlightenment/modules"
EFL_GIT_REPO_NAME="${PN#e_modules-}"
inherit efl

DESCRIPTION="The forecasts gadget."

DEPEND="x11-wm/enlightenment"

RDEPEND="${DEPEND}"
