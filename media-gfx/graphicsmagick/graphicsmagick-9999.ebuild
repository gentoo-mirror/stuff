# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"

inherit eutils toolchain-funcs flag-o-matic perl-module mercurial

MY_P=${P/graphicsm/GraphicsM}

DESCRIPTION="GraphicsMagick is the swiss army knife of image processing."
HOMEPAGE="http://www.graphicsmagick.org/"
EHG_REPO_URI="http://graphicsmagick.hg.sourceforge.net:8000/hgroot/graphicsmagick/graphicsmagick"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="bzip2 cxx debug doc fpx imagemagick jbig jpeg jpeg2k lzma lcms modules openmp
	perl png q8 q16 q32 svg threads tiff truetype X wmf zlib"

RDEPEND="app-text/ghostscript-gpl
	bzip2? ( app-arch/bzip2 )
	fpx? ( media-libs/libfpx )
	jbig? ( media-libs/jbigkit )
	jpeg? ( virtual/jpeg )
	jpeg2k? ( >=media-libs/jasper-1.701.0 )
	lcms? ( media-libs/lcms:2 )
	perl? ( dev-lang/perl )
	png? ( media-libs/libpng )
	svg? ( dev-libs/libxml2 )
	tiff? ( >=media-libs/tiff-3.8.2 )
	truetype? ( media-libs/freetype:2 )
	wmf? ( media-libs/libwmf )
	X? ( x11-libs/libXext x11-libs/libSM )
	imagemagick? ( !media-gfx/imagemagick )"

DEPEND="${RDEPEND}"

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	if use openmp &&
		[[ $(tc-getCC)$ == *gcc* ]] &&
		( [[ $(gcc-major-version)$(gcc-minor-version) -lt 42 ]] ||
			! has_version sys-devel/gcc[openmp] )
	then
		ewarn "You are using gcc and OpenMP is only available with gcc >= 4.2 "
		ewarn "If you want to build fftw with OpenMP, abort now,"
		ewarn "and switch CC to an OpenMP capable compiler"
		epause 5
	fi
}

src_configure() {
	local quantumDepth=16
	use q8 && quantumDepth=8
	use q32 && quantumDepth=32

	use debug && filter-flags -fomit-frame-pointer
	econf \
		--docdir="${EPREFIX}"/usr/share/doc/${PF} \
		--htmldir="${EPREFIX}"/usr/share/doc/${PF}/html \
		--enable-shared \
		--enable-largefile \
		--without-included-ltdl \
		--without-frozenpaths \
		--without-gslib \
		--with-quantum-depth=${quantumDepth} \
		--with-fontpath="${EPREFIX}/usr/share/fonts" \
		--with-gs-font-dir="${EPREFIX}/usr/share/fonts/default/ghostscript" \
		--with-windows-font-dir="${EPREFIX}/usr/share/fonts/corefonts" \
		--with-perl-options="INSTALLDIRS=vendor" \
		$(use_enable debug ccmalloc) \
		$(use_enable debug prof) \
		$(use_enable debug gcov) \
		$(use_enable imagemagick magick-compat) \
		$(use_enable openmp) \
		$(use_with bzip2 bzlib) \
		$(use_with cxx magick-plus-plus) \
		$(use_with fpx) \
		$(use_with jbig) \
		$(use_with jpeg) \
		$(use_with jpeg2k jp2) \
		$(use_with lzma) \
		--without-lcms \
		$(use_with lcms lcms2) \
		$(use_with modules) \
		$(use_with perl) \
		$(use_with png) \
		$(use_with svg xml) \
		$(use_with threads) \
		$(use_with tiff) \
		$(use_with truetype ttf) \
		$(use_with wmf) \
		$(use_with X x) \
		$(use_with zlib)
}

src_compile() {
	emake || die "emake failed"
	if use perl; then
		emake perl-build || die "emake perl failed"
	fi
}

src_test() {
	emake check || die "tests failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	if use perl; then
		perl -MExtUtils::MakeMaker -e 'MY->fixin(@ARGV)' PerlMagick/demo/*.pl
		emake -C PerlMagick DESTDIR="${D}" \
			install || die "emake perl install failed"
		fixlocalpod
	fi
	use doc || rm -rf "${D}"usr/share/doc/${PF}/html
}
