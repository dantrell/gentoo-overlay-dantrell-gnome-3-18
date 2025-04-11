# Distributed under the terms of the GNU General Public License v2

EAPI="6"
GNOME2_LA_PUNT="yes"

inherit gnome2

DESCRIPTION="GNOME framework for accessing online accounts"
HOMEPAGE="https://wiki.gnome.org/Projects/GnomeOnlineAccounts"

LICENSE="LGPL-2+"
SLOT="0/1"
KEYWORDS="*"

IUSE="debug gnome +introspection kerberos" # telepathy"

# pango used in goaeditablelabel
# libsoup used in goaoauthprovider
# goa kerberos provider is incompatible with app-crypt/heimdal, see
# https://bugzilla.gnome.org/show_bug.cgi?id=692250
# json-glib-0.16 needed for bug #485092
RDEPEND="
	>=dev-libs/glib-2.40:2
	>=app-crypt/libsecret-0.5
	>=dev-libs/json-glib-0.16
	dev-libs/libxml2:2
	>=net-libs/libsoup-2.42:2.4
	net-libs/rest:0.7
	net-libs/telepathy-glib
	>=net-libs/webkit-gtk-2.7.2:4
	>=x11-libs/gtk+-3.11.1:3
	x11-libs/pango

	introspection? ( >=dev-libs/gobject-introspection-0.6.2:= )
	kerberos? (
		app-crypt/gcr:0=[gtk]
		app-crypt/mit-krb5 )
"
#	telepathy? ( net-libs/telepathy-glib )
# goa-daemon can launch gnome-control-center
PDEPEND="gnome? ( >=gnome-base/gnome-control-center-3.2[gnome-online-accounts(+)] )"

DEPEND="${RDEPEND}
	dev-libs/libxslt
	>=dev-build/gtk-doc-am-1.3
	>=dev-util/gdbus-codegen-2.30.0
	>=dev-util/intltool-0.50.1
	sys-devel/gettext
	virtual/pkgconfig

	dev-libs/gobject-introspection-common
	gnome-base/gnome-common
"
# eautoreconf needs gobject-introspection-common, gnome-common

PATCHES=(
	# From GNOME:
	# 	https://gitlab.gnome.org/GNOME/gnome-online-accounts/-/commit/5dc30f43e6c721708a6d15fcfcd086a11d41bc2d
	# 	https://gitlab.gnome.org/GNOME/gnome-online-accounts/-/commit/01882bde514aae12796c98e03818f8d30cbd13b9
	# 	https://gitlab.gnome.org/GNOME/gnome-online-accounts/-/commit/53ce478c99d43f0cf8333e452edd228418112a2d
	# 	https://gitlab.gnome.org/GNOME/gnome-online-accounts/-/commit/674330b0ccb816530ee6d31cea0f752e334f15d7
	# 	https://gitlab.gnome.org/GNOME/gnome-online-accounts/-/commit/924689ce724cc0f1b893e1e0845c04f59eabd765
	# 	https://gitlab.gnome.org/GNOME/gnome-online-accounts/-/commit/f5325f00c0d2cae9e5f6253c59c713c4b223af1f
	# 	https://gitlab.gnome.org/GNOME/gnome-online-accounts/-/commit/1ba36012879083330871c301464daf7615f7d7d0
	# 	https://gitlab.gnome.org/GNOME/gnome-online-accounts/-/commit/094d8b7f42cdacd307e43347cefae8299c676bb2
	# 	https://gitlab.gnome.org/GNOME/gnome-online-accounts/-/commit/389ce7fad248998178778ca4a95dd8d09d4f38eb
	# 	https://gitlab.gnome.org/GNOME/gnome-online-accounts/-/commit/236987b0dc06fb429e319bd29a2e9227b78b35e1
	# 	https://gitlab.gnome.org/GNOME/gnome-online-accounts/-/commit/ee460859029833c7e607f668270d5946525e7d18
	# 	https://gitlab.gnome.org/GNOME/gnome-online-accounts/-/commit/2893345fb5a81ae2de631ea82d4e9ff467c610f6
	# 	https://gitlab.gnome.org/GNOME/gnome-online-accounts/-/commit/1f18560d1c151d69f2f72b63c436cfe2b86443a1
	# 	https://gitlab.gnome.org/GNOME/gnome-online-accounts/-/commit/5583ceb2d001655a492446238ac8074e31c7d2c9
	"${FILESDIR}"/${PN}-3.20.5-build-new-api-key-for-google.patch
	"${FILESDIR}"/${PN}-3.20.6-goa-identity-manager-get-identity-finish-should-return-a-new-ref.patch
	"${FILESDIR}"/${PN}-3.20.6-identity-fix-the-error-handling-when-signing-out-an-identity.patch
	"${FILESDIR}"/${PN}-3.20.6-identity-fix-ensure-credentials-for-accounts-leak.patch
	"${FILESDIR}"/${PN}-3.20.6-identity-dont-leak-the-invocation-when-handling-exchangesecretkeys.patch
	"${FILESDIR}"/${PN}-3.20.6-daemon-dont-leak-the-provider-when-coalescing-ensurecredential-calls.patch
	"${FILESDIR}"/${PN}-3.20.6-kerberos-style-fixes.patch
	"${FILESDIR}"/${PN}-3.20.6-kerberos-dont-leak-the-return-key-in-sign-in-identity-sync.patch
	"${FILESDIR}"/${PN}-3.20.6-identity-dont-leak-operation-result-when-handling-exchangesecretkeys.patch
	"${FILESDIR}"/${PN}-3.20.6-identity-dont-leak-the-invocation-when-handling-signout.patch
	"${FILESDIR}"/${PN}-3.20.8-google-update-is-identity-node-to-match-the-web-ui.patch
	"${FILESDIR}"/${PN}-3.20.8-facebook-avoid-criticals-if-get-identity-sync-cant-parse-the-response.patch
	"${FILESDIR}"/${PN}-3.20.8-facebook-make-it-work-with-graph-api-2-3.patch
	"${FILESDIR}"/${PN}-3.20.8-facebook-update-readme.patch
)

# Due to sub-configure
QA_CONFIGURE_OPTIONS=".*"

src_configure() {
	# TODO: Give users a way to set the G/FB/Windows Live secrets
	# telepathy optional support is really badly done, bug #494456
	gnome2_src_configure \
		--disable-static \
		--enable-backend \
		--enable-documentation \
		--enable-exchange \
		--enable-facebook \
		--enable-flickr \
		--enable-foursquare \
		--enable-imap-smtp \
		--enable-lastfm \
		--enable-media-server \
		--enable-owncloud \
		--enable-pocket \
		--enable-telepathy \
		--enable-windows-live \
		$(usex debug --enable-debug=yes ' ') \
		$(use_enable kerberos) \
		$(use_enable introspection)
		#$(use_enable telepathy)
	# gudev & cheese from sub-configure is overriden
	# by top level configure, and disabled so leave it like that
}
