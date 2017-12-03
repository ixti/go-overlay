# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

GOLANG_PKG_IMPORTPATH="github.com/justwatchcom"
GOLANG_PKG_ARCHIVEPREFIX="v"
GOLANG_PKG_LDFLAGS="-extldflags '-static' -X main.version=${PV}"
GOLANG_PKG_HAVE_TEST=1

inherit golang-single

DESCRIPTION="The slightly more awesome standard unix password manager for teams"
HOMEPAGE="https://www.justwatch.com/gopass"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="fish-completion dmenu"

DEPEND="app-crypt/gpgme:1
	dev-vcs/git[threads,gpg,curl]
	dmenu? ( x11-misc/dmenu x11-misc/xdotool )"
RDEPEND="${DEPEND}
	fish-completion? ( app-shells/fish )"

DOCS+=" docs/*"

src_install() {
	golang-single_src_install

	# Install fish completion files
	if use fish-completion; then
		insinto /usr/share/fish/functions/
		newins fish.completion ${PN}.fish
	fi
}

src_test() {
	GOLANG_PKG_IS_MULTIPLE=1
	golang-single_src_test
}