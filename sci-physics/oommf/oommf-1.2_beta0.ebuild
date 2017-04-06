# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

DESCRIPTION="The Object Oriented MicroMagnetic Framework"
HOMEPAGE="http://math.nist.gov/oommf/"
SRC_URI="http://math.nist.gov/oommf/dist/${PN}12b0_20160930.tar.gz"

LICENSE="HPND"
KEYWORDS="~x86 ~amd64 ~arm"
IUSE="doc"
SLOT="1.2"

DEPEND="
dev-lang/tcl:=
dev-lang/tk:="
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}"

src_compile() {
	tclsh oommf.tcl pimake distclean
	tclsh oommf.tcl pimake upgrade
	tclsh oommf.tcl pimake
}

src_install()
{
	tclsh oommf.tcl pimake objclean

	local oommf_dir="/opt/oommf"
	use doc && dodoc "./doc/userguide/userguide.pdf"
	use doc && dodoc "./doc/progman/progman.pdf"
	rm -rf "./doc"
	dodoc README
	dodir ${oommf_dir} || die
	mv  * "${ED}"${oommf_dir} || die
	cat > oommf.sh <<- EOF
	#!/usr/bin/env sh
	/opt/oommf/oommf.tcl
	EOF

	dodir /opt/bin
	exeinto /opt/bin
	doexe oommf.sh
}