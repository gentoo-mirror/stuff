# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..12} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 optfeature

DESCRIPTION="Image processing routines for SciPy"
HOMEPAGE="https://scikit-image.org/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	dev-python/imageio[${PYTHON_USEDEP}]
	dev-python/matplotlib[${PYTHON_USEDEP}]
	dev-python/networkx[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/pillow[${PYTHON_USEDEP}]
	dev-python/pywavelets[${PYTHON_USEDEP}]
	dev-python/scipy[${PYTHON_USEDEP}]
	dev-python/sparse[${PYTHON_USEDEP}]
	dev-python/tifffile[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}
	dev-python/cython[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]
"

DOCS=( CONTRIBUTORS.txt RELEASE.txt )

pkg_postinst() {
	optfeature "FITS io capability" dev-python/astropy
	optfeature "GTK" dev-python/pygtk
	optfeature "Parallel computation" dev-python/dask
	optfeature "io plugin providing most standard formats" dev-python/imread
	# not in portage yet
	#optfeature "io plugin providing a wide variety of formats, including specialized formats using in medical imaging." dev-python/simpleitk
}
