# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit autotools gnome2

DESCRIPTION="Note editor designed to remain simple to use"
HOMEPAGE="https://wiki.gnome.org/Apps/Bijiben"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="*"

IUSE="zeitgeist"

RDEPEND="
	>=dev-libs/glib-2.28:2
	>=x11-libs/gtk+-3.11.4:3
	>=gnome-extra/evolution-data-server-3.13.90:=
	net-libs/webkit-gtk:4
	net-libs/gnome-online-accounts:=
	dev-libs/libxml2
	>=app-misc/tracker-1:=
	sys-apps/util-linux
	zeitgeist? ( gnome-extra/zeitgeist )
"
DEPEND="${RDEPEND}
	app-text/yelp-tools
	dev-libs/appstream-glib
	dev-util/gdbus-codegen
	>=dev-util/intltool-0.50.1
	dev-util/itstool
	sys-devel/gettext
	virtual/pkgconfig
"

src_prepare() {
	# From GNOME:
	# 	https://git.gnome.org/browse/bijiben/commit/?id=35ea9386d2ad7f7cf043592462c0c3486892dee1
	# 	https://git.gnome.org/browse/bijiben/commit/?id=81a8fe5245119663f15edb32aebaf9ebe3be5306
	# 	https://git.gnome.org/browse/bijiben/commit/?id=8811ff5003a1129550b2f522a80cd302e91b05e8
	# 	https://git.gnome.org/browse/bijiben/commit/?id=bff3cc849ca05d6017620ee9849888e84a963a71
	# 	https://git.gnome.org/browse/bijiben/commit/?id=0c5e079ca1a3c323c6d1c99603ff06f10c535fed
	# 	https://git.gnome.org/browse/bijiben/commit/?id=d74e55ac1fb7c865c0d57368da5a94a45a60bcd6
	# 	https://git.gnome.org/browse/bijiben/commit/?id=fb7b8bbac5ef3591d2f940f3034a4390468ad01d
	# 	https://git.gnome.org/browse/bijiben/commit/?id=ea3610066fd643f8fb7c5317721ef1dcb0bd6325
	# 	https://git.gnome.org/browse/bijiben/commit/?id=389bb2e29786739b4a9d0199896f070e4ce85cdb
	# 	https://git.gnome.org/browse/bijiben/commit/?id=d3a8ba13bb6dfbdaa8a03f35c649c76f7b4b5252
	# 	https://git.gnome.org/browse/bijiben/commit/?id=3f4faecf8f718ea79de61b5fd9dfb51eac6fe571
	# 	https://git.gnome.org/browse/bijiben/commit/?id=226c8314915e48cfc5414d99fcabde50cdb75ab5
	# 	https://git.gnome.org/browse/bijiben/commit/?id=257a48d87dde3347814ecf5a9beee0607334022d
	# 	https://git.gnome.org/browse/bijiben/commit/?id=59540468524d86524f51bd08fd7702a38a0aa4b1
	# 	https://git.gnome.org/browse/bijiben/commit/?id=533c0f6a7207a0a72083734c16ec603784c50804
	# 	https://git.gnome.org/browse/bijiben/commit/?id=f55eefec841486a448a9f29cae7baaf1440c0b33
	# 	https://git.gnome.org/browse/bijiben/commit/?id=47f3c4bd81d644f1a13f853cdf54f44cb252f0d2
	# 	https://git.gnome.org/browse/bijiben/commit/?id=23a9d21a1a9be95b2bbf6626d80ede3b4a989fda
	# 	https://git.gnome.org/browse/bijiben/commit/?id=efcabf00020fe01fee75a3f55ae7a48e83de37d6
	# 	https://git.gnome.org/browse/bijiben/commit/?id=97cd9faec88615d71c99989cbab42fccd778cb9f
	# 	https://git.gnome.org/browse/bijiben/commit/?id=b077a604b0559620b77526a1b8b0875dd3ce0e30
	# 	https://git.gnome.org/browse/bijiben/commit/?id=1048328eae48ebb9de6be3a7286259d671c5034d
	# 	https://git.gnome.org/browse/bijiben/commit/?id=ef9698724a23be5d5f5233405324889bf25ca201
	# 	https://git.gnome.org/browse/bijiben/commit/?id=10b3a74b11433b7c70418a6fdde162bd8d42adaf
	# 	https://git.gnome.org/browse/bijiben/commit/?id=439b089fd9253d85654e121b886366a76223646d
	# 	https://git.gnome.org/browse/bijiben/commit/?id=9f937210ef8e3b13cdcb4fd962723063eb0419c4
	eapply "${FILESDIR}"/${PN}-3.19.3-make-zeitgeist-dependency-optional.patch
	eapply "${FILESDIR}"/${PN}-3.24.0-bjb-editor-toolbar-moved-from-gtkpopover-to-gtkactionbar.patch
	eapply "${FILESDIR}"/${PN}-3.24.0-bjb-editor-toolbar-moved-ui-definition-to-a-template-file.patch
	eapply "${FILESDIR}"/${PN}-3.24.0-build-remove-dependancy-on-libedataserverui.patch
	eapply "${FILESDIR}"/${PN}-3.24.0-bjb-bijiben-fixed-two-memory-leaks.patch
	eapply "${FILESDIR}"/${PN}-3.24.0-editor-remove-unused-code-in-preparation-for-webkit2-port.patch
	eapply "${FILESDIR}"/${PN}-3.24.0-port-to-webkit2.patch
	eapply "${FILESDIR}"/${PN}-3.24.0-note-view-fix-background-color.patch
	eapply "${FILESDIR}"/${PN}-3.24.0-fix-some-memory-leaks.patch
	eapply "${FILESDIR}"/${PN}-3.24.0-bjb-bijiben-initialize-remaining-as-null.patch
	eapply "${FILESDIR}"/${PN}-3.24.0-src-move-all-declarations-to-the-top-of-blocks.patch
	eapply "${FILESDIR}"/${PN}-3.24.0-fix-some-memory-leaks2.patch
	eapply "${FILESDIR}"/${PN}-3.24.0-note-view-segfault-back-button.patch
	eapply "${FILESDIR}"/${PN}-3.24.0-biji-note-obj-added-const-qualifier-to-return-type.patch
	eapply "${FILESDIR}"/${PN}-3.24.0-biji-webkit-editor-fixed-toggle-block-format-switch.patch
	eapply "${FILESDIR}"/${PN}-3.24.0-biji-webkit-editor-fixed-mixed-declarations-and-code.patch
	eapply "${FILESDIR}"/${PN}-3.24.0-note-obj-convert-webkit1-to-webkit2-notes.patch
	eapply "${FILESDIR}"/${PN}-3.24.0-editor-toolbar-remove-accelerators.patch
	eapply "${FILESDIR}"/${PN}-3.24.1-local-provider-remove-warning-about-trash-folder.patch
	eapply "${FILESDIR}"/${PN}-3.24.1-local-note-purge-memory-leak-when-deleting-note.patch
	eapply "${FILESDIR}"/${PN}-3.24.1-local-provider-purge-memory-leak.patch
	eapply "${FILESDIR}"/${PN}-3.24.1-serializer-purge-memory-leak-on-save.patch
	eapply "${FILESDIR}"/${PN}-3.24.1-window-base-transparent-main-window.patch
	eapply "${FILESDIR}"/${PN}-3.26.0-note-obj-critical-error-when-creating-a-new-note.patch
	eapply "${FILESDIR}"/${PN}-3.26.0-notebook-add-an-empty-method-for-delete.patch
	eapply "${FILESDIR}"/${PN}-3.26.0-main-view-crash-when-closing-app-with-empty-note.patch

	eautoreconf
	gnome2_src_prepare
}

src_configure() {
	gnome2_src_configure \
		$(use_enable zeitgeist) \
		--disable-update-mimedb
}