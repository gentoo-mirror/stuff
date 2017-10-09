# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit eutils git-r3

DESCRIPTION="Spectrogram plugin for DeaDBeeF audio player"
HOMEPAGE="https://github.com/cboxdoerfer/ddb_spectrogram"
EGIT_REPO_URI="https://github.com/cboxdoerfer/ddb_spectrogram.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="gtk2 gtk3"

DEPEND_COMMON="
	sci-libs/fftw:3.0
	gtk2? ( media-sound/deadbeef[gtk2] )
	gtk3? ( media-sound/deadbeef[gtk3] )"

RDEPEND="${DEPEND_COMMON}"
DEPEND="${DEPEND_COMMON}"

src_compile() {
	use gtk2 && emake gtk2
	use gtk3 && emake gtk3
}

src_install() {
	insinto /usr/$(get_libdir)/deadbeef
	use gtk2 && doins gtk2/ddb_vis_spectrogram_GTK2.so
	use gtk3 && doins gtk3/ddb_vis_spectrogram_GTK3.so
}
