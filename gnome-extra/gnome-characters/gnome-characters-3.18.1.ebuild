# Distributed under the terms of the GNU General Public License v2

EAPI="6"
VALA_USE_DEPEND="vapigen"

inherit gnome2 vala

DESCRIPTION="Unicode character map viewer and library"
HOMEPAGE="https://wiki.gnome.org/Design/Apps/CharacterMap"

LICENSE="GPL-2 BSD"
SLOT="0"
KEYWORDS="*"

IUSE=""

RESTRICT="test"

RDEPEND="
	>=dev-libs/gjs-1.43.3
	>=dev-libs/glib-2.32:2
	>=dev-libs/gobject-introspection-1.35.9:=
	>=dev-libs/libunistring-0.9.5
	>=x11-libs/gtk+-3:3[introspection]
	>=x11-libs/pango-1.36[introspection]
"
DEPEND="${RDEPEND}
	dev-libs/appstream-glib
	>=dev-util/intltool-0.50.1
	sys-devel/gettext
	virtual/pkgconfig
"

src_prepare() {
	vala_src_prepare
	gnome2_src_prepare
}

src_configure() {
	gnome2_src_configure --disable-dogtail
}
