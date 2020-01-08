Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

EGIT_REPO_URI="https://github.com/strophe/libstrophe.git"

inherit autotools git-r3

DESCRIPTION="A simple, lightweight C library for writing XMPP clients"
HOMEPAGE="http://strophe.im/libstrophe/"

LICENSE="MIT GPL-3"
SLOT="0"
KEYWORDS=""
IUSE="doc libressl -xml"

RDEPEND="xml? ( dev-libs/libxml2 )
		!xml? ( dev-libs/expat )
		libressl? ( dev-libs/libressl:0= )
		!libressl? ( dev-libs/openssl:0= )"
DEPEND="${RDEPEND}
		doc? ( app-doc/doxygen )"

src_prepare() {
		default

		eautoreconf
}

src_configure() {
		econf $(use_with xml libxml2)
}

src_compile() {
		default

		if use doc; then
			doxygen || die
		fi
}

src_install() {
		DOCS="GPL-LICENSE.txt LICENSE.txt MIT-LICENSE.txt README.markdown ChangeLog"
		if use doc; then
			HTML_DOCS="docs/html/*"
		fi

		default
}
