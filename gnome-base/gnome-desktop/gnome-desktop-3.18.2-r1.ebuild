# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit gnome2 virtualx

DESCRIPTION="Libraries for the gnome desktop that are not part of the UI"
HOMEPAGE="https://git.gnome.org/browse/gnome-desktop"

LICENSE="GPL-2+ FDL-1.1+ LGPL-2+"
SLOT="3/12" # subslot = libgnome-desktop-3 soname version
KEYWORDS="*"

IUSE="debug +introspection"

# cairo[X] needed for gnome-bg
COMMON_DEPEND="
	app-text/iso-codes
	>=dev-libs/glib-2.44.0:2[dbus]
	>=x11-libs/gdk-pixbuf-2.33.0:2[introspection?]
	>=x11-libs/gtk+-3.3.6:3[X,introspection?]
	>=x11-libs/libXext-1.1
	>=x11-libs/libXrandr-1.3
	x11-libs/cairo:=[X]
	x11-libs/libX11
	x11-misc/xkeyboard-config
	>=gnome-base/gsettings-desktop-schemas-3.5.91
	introspection? ( >=dev-libs/gobject-introspection-0.9.7:= )
"
RDEPEND="${COMMON_DEPEND}
	!<gnome-base/gnome-desktop-2.32.1-r1:2[doc]
"
DEPEND="${COMMON_DEPEND}
	app-text/docbook-xml-dtd:4.1.2
	dev-util/gdbus-codegen
	>=dev-util/gtk-doc-am-1.14
	>=dev-util/intltool-0.40.6
	dev-util/itstool
	sys-devel/gettext
	x11-proto/xproto
	>=x11-proto/randrproto-1.2
	virtual/pkgconfig
"

# Includes X11/Xatom.h in libgnome-desktop/gnome-bg.c which comes from xproto
# Includes X11/extensions/Xrandr.h that includes randr.h from randrproto (and
# eventually libXrandr shouldn't RDEPEND on randrproto)

src_prepare() {
	# From GNOME:
	# 	https://git.gnome.org/browse/gnome-desktop/commit/?id=f9b2c480e38de4dbdd763137709a523f206a8d1b
	# 	https://git.gnome.org/browse/gnome-desktop/commit/?id=70d46d5cd8bac0de99fed21ee2247ec74b03991b
	eapply "${FILESDIR}"/${PN}-3.19.1-thumbnail-ignore-errors-when-not-all-frames-are-loaded.patch
	eapply "${FILESDIR}"/${PN}-3.19.1-build-require-the-newest-gdk-pixbuf.patch
}

src_configure() {
	# Note: do *not* use "--with-pnp-ids-path" argument. Otherwise, the pnp.ids
	# file (needed by other packages such as >=gnome-settings-daemon-3.1.2)
	# will not get installed in ${pnpdatadir} (/usr/share/libgnome-desktop-3.0).
	gnome2_src_configure \
		--disable-static \
		--with-gnome-distributor=Gentoo \
		--enable-desktop-docs \
		$(usex debug --enable-debug=yes ' ') \
		$(use_enable introspection)
}

src_test() {
	virtx emake check
}