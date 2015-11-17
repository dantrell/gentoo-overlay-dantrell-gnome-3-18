# Distributed under the terms of the GNU General Public License v2

EAPI="5"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"

inherit gnome2

DESCRIPTION="A simplistic personal task manager"
HOMEPAGE="https://wiki.gnome.org/Apps/Todo"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="*"
IUSE=""

RDEPEND="
	>=dev-libs/glib-2.43.4:2
	dev-libs/libical:0=
	>=dev-libs/libxml2-2
	>=gnome-extra/evolution-data-server-3.13.90:0=
	>=mail-client/evolution-3.13.90:2.0
	>=x11-libs/gtk+-3.16:3
"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.40.6
	virtual/pkgconfig
"
