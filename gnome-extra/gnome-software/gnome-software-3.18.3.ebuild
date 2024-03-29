# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit gnome2 virtualx

DESCRIPTION="GNOME utility for installing applications and updating systems"
HOMEPAGE="https://wiki.gnome.org/Apps/Software https://gitlab.gnome.org/GNOME/gnome-software"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="*"

IUSE="firmware"

RDEPEND="
	>=app-admin/packagekit-base-1
	dev-db/sqlite:3
	>=dev-libs/appstream-glib-0.5.1:0
	<dev-libs/appstream-glib-0.5.12
	>=dev-libs/glib-2.45.8:2
	>=gnome-base/gnome-desktop-3.17.92:3=
	>=gnome-base/gsettings-desktop-schemas-3.11.5
	net-libs/libsoup:2.4
	sys-auth/polkit
	firmware? (
		>=sys-apps/fwupd-0.7.0
		<sys-apps/fwupd-1.0
	)
	>=x11-libs/gtk+-3.16:3
"
DEPEND="${RDEPEND}"
BDEPEND="
	app-text/docbook-xml-dtd:4.2
	dev-libs/libxslt
	>=dev-util/intltool-0.35
	virtual/pkgconfig
"

src_configure() {
	gnome2_src_configure \
		--enable-man \
		$(use_enable firmware) \
		--disable-limba \
		--disable-dogtail
}

src_install() {
	gnome2_src_install

	# From AppStream (the /usr/share/appdata location is deprecated):
	# 	https://www.freedesktop.org/software/appstream/docs/chap-Metadata.html#spec-component-location
	# 	https://bugs.gentoo.org/709450
	mv "${ED}"/usr/share/{appdata,metainfo} || die

	find "${ED}" -type f -name "*.la" -delete || die
}
