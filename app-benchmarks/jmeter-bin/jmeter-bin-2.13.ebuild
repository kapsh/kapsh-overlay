EAPI="5"

inherit java-pkg-2 java-ant-2

KEYWORDS="~amd64 ~x86"

LICENSE="Apache-2.0"
DESCRIPTION="Load test and measure performance on HTTP/FTP services and databases."
SLOT="0"
RESTRICT="mirror"

JM_PLUGINS="+pl_standard +pl_extras
	pl_extraslibs pl_hadoop pl_webdriver"
IUSE="beanshell doc ${JM_PLUGINS}"

HOMEPAGE="http://jmeter.apache.org/ http://jmeter-plugins.org/"
SRC_URI="http://archive.apache.org/dist/jmeter/binaries/apache-jmeter-${PV}.tgz
	pl_standard? ( http://jmeter-plugins.org/downloads/file/JMeterPlugins-Standard-1.3.1.zip )
	pl_extras? ( http://jmeter-plugins.org/downloads/file/JMeterPlugins-Extras-1.3.1.zip )
	pl_extraslibs? ( http://jmeter-plugins.org/downloads/file/JMeterPlugins-ExtrasLibs-1.3.1.zip )
	pl_webdriver? ( http://jmeter-plugins.org/downloads/file/JMeterPlugins-WebDriver-1.3.1.zip )
	pl_hadoop? ( http://jmeter-plugins.org/downloads/file/JMeterPlugins-Hadoop-1.3.1.zip ) "

COMMON_DEP="
	beanshell? ( dev-java/bsh )
	>=dev-java/bsf-2.3
	=dev-java/junit-3.8*
	java-virtuals/javamail"
DEPEND=">=virtual/jdk-1.6
	doc? ( >=dev-java/velocity-1.4 )
	dev-java/ant-nodeps
	sys-apps/sed
	${COMMON_DEP}"
RDEPEND=">=virtual/jre-1.6
	${COMMON_DEP}"

S="${WORKDIR}/apache-jmeter-${PV}"

src_unpack() {
	unpack "apache-jmeter-${PV}.tgz"
	cd "${S}"
	use pl_standard && unpack "JMeterPlugins-Standard-1.3.1.zip"
	use pl_extras && unpack "JMeterPlugins-Extras-1.3.1.zip"
	use pl_extraslibs && unpack "JMeterPlugins-ExtrasLibs-1.3.1.zip"
	use pl_webdriver && unpack "JMeterPlugins-WebDriver-1.3.1.zip"
	use pl_hadoop && unpack "JMeterPlugins-Hadoop-1.3.1.zip"
}

src_prepare() {
	epatch "${FILESDIR}/tune-launcher.patch"
}

src_install() {
	DIROPTIONS="--mode=0775"
	dodir /opt/${PN}
	dodir /usr/bin
	local dest="${D}/opt/${PN}/"
	cp -pPR bin/ lib/ README "${dest}"
	if use doc; then
		cp -pPR printable_docs "${dest}" || die "Failed to install docs"
	fi
	dodoc README || die
	dosym "/opt/${PN}/bin/jmeter" "/usr/bin/jmeter"
	make_desktop_entry "jmeter" "Apache JMeter"
	use doc && dohtml -r docs/*
}

pkg_postinst() {
	einfo "For using properly with some window managers try install x11-misc/wmname"
}
