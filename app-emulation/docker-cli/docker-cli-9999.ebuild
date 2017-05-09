# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
EGO_PN='github.com/docker/cli/...'

case "${PV}" in
	*9999)
		inherit golang-vcs
		;;

	*)
		MY_PV="${PV/_/-}"
		EGIT_COMMIT="v${MY_PV}"
		SRC_URI="https://${EGO_PN%/...}/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
		KEYWORDS="~amd64"
		inherit golang-vcs-snapshot
		;;
esac

DESCRIPTION="The Docker CLI"
HOMEPAGE="https://github.com/docker/cli"

LICENSE="Apache-2.0"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND="
	!<app-emulation/docker-17.06
"

S="${WORKDIR}/${P}/src/${EGO_PN%/...}"

src_compile() {
	export GOPATH="${WORKDIR}/${P}"
	emake
}

src_install() {
	dobin build/docker
}
