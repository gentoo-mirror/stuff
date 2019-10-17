# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_5 python3_6 python3_7)

inherit distutils-r1 flag-o-matic

DESCRIPTION="A library for least-squares minimization and data fitting in Python"
HOMEPAGE="https://lmfit.github.io/lmfit-py/"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc python"

RDEPEND="
	>=dev-python/asteval-0.9.12
	>=dev-python/numpy-1.10
	>=sci-libs/scipy-0.19
	>=dev-python/uncertainties-3.0
	>=dev-python/six-1.10
"
#dev-python/PyQt4

DEPEND="${RDEPEND}
	doc? ( dev-util/gtk-doc )
"

REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"

python_compile() {
	distutils-r1_python_compile
}

python_compile_all() {
	use doc && setup.py build
}

python_test() {
	setup.py test
}

python_install_all() {
	distutils-r1_python_install_all
}
