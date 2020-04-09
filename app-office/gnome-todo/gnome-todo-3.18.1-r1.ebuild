# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit gnome2

DESCRIPTION="Personal task manager"
HOMEPAGE="https://wiki.gnome.org/Apps/Todo"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="*"

IUSE=""

RDEPEND="
	>=dev-libs/glib-2.43.4:2
	>=dev-libs/libical-0.43:=
	>=gnome-extra/evolution-data-server-3.17.1:=[gtk]
	>=net-libs/gnome-online-accounts-3.2:=
	>=x11-libs/gtk+-3.16:3
"
DEPEND="${RDEPEND}
	dev-libs/appstream-glib
	>=dev-util/intltool-0.40.6
	sys-devel/gettext
	virtual/pkgconfig
"

src_prepare() {
	# From GNOME:
	# 	https://gitlab.gnome.org/GNOME/gnome-todo/commit/6de8adc351b758c1d608ae0ea8acf6d35ed502ea
	eapply "${FILESDIR}"/${PN}-3.26.2-eds-build-with-libical-3-0.patch

	gnome2_src_prepare
}
