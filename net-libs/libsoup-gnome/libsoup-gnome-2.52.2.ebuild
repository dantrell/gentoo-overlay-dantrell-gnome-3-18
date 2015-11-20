# Distributed under the terms of the GNU General Public License v2

EAPI="5"
GCONF_DEBUG="yes"
GNOME2_LA_PUNT="yes"

MY_PN=${PN/-gnome}
MY_P=${MY_PN}-${PV}

inherit autotools eutils gnome2 multilib-minimal

DESCRIPTION="GNOME plugin for libsoup"
HOMEPAGE="https://wiki.gnome.org/LibSoup"
SRC_URI="${SRC_URI//-gnome}"

LICENSE="LGPL-2+"
SLOT="2.4"
IUSE="+introspection"
KEYWORDS="*"

RDEPEND="
	~net-libs/libsoup-${PV}[introspection?,${MULTILIB_USEDEP}]
	dev-db/sqlite:3=[${MULTILIB_USEDEP}]
	introspection? ( >=dev-libs/gobject-introspection-0.9.5:= )
"
DEPEND="${RDEPEND}
	>=dev-util/gtk-doc-am-1.10
	>=dev-util/intltool-0.35
	sys-devel/gettext
	virtual/pkgconfig[${MULTILIB_USEDEP}]
"

S=${WORKDIR}/${MY_P}

src_prepare() {
	# Use lib present on the system
	epatch "${FILESDIR}"/${PN}-2.52.2-system-lib.patch
	eautoreconf
	gnome2_src_prepare
}

multilib_src_configure() {
	# FIXME: we need addpredict to workaround bug #324779 until
	# root cause (bug #249496) is solved
	addpredict /usr/share/snmp/mibs/.index

	# Disable apache tests until they are usable on Gentoo, bug #326957
	ECONF_SOURCE=${S} \
	gnome2_src_configure \
		--disable-static \
		--disable-tls-check \
		$(multilib_native_use_enable introspection) \
		--with-libsoup-system \
		--with-gnome \
		--without-apache-httpd \
		--disable-vala
}

multilib_src_compile() { gnome2_src_compile; }
multilib_src_install() { gnome2_src_install; }
