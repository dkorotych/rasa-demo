#!/usr/bin/env bash

set -e
set -u

JMETER_VERSION="5.2.1"
GECKODRIVER_VERSION="v0.26.0"
JMETER_HOME="$(dirname $(readlink -f $0))/jmeter"
JMETER_BIN="$JMETER_HOME/bin"

CMDRUNNER_VERSION="2.2"

if [ -d "$JMETER_HOME" ]; then
  echo "Application already exists. You should remove $JMETER_HOME directory for reinstall"
  exit 1
fi

mkdir -p "$JMETER_HOME"
echo "Download and install Apache JMeter"
curl --location --silent --show-error "https://archive.apache.org/dist/jmeter/binaries/apache-jmeter-$JMETER_VERSION.tgz" | tar -xz --strip=1 -C "$JMETER_HOME"
echo "Install plugin manager"
curl --location --silent --show-error --output "$JMETER_HOME/lib/ext/plugins-manager.jar" https://jmeter-plugins.org/get
curl --location --silent --show-error --output "$JMETER_HOME/lib/cmdrunner-$CMDRUNNER_VERSION.jar" "http://search.maven.org/remotecontent?filepath=kg/apc/cmdrunner/$CMDRUNNER_VERSION/cmdrunner-$CMDRUNNER_VERSION.jar"
java -cp "$JMETER_HOME/lib/ext/plugins-manager.jar" org.jmeterplugins.repository.PluginManagerCMDInstaller
echo "Install WebDriver plugin and dependencies"
"$JMETER_BIN/PluginsManagerCMD.sh" install jpgc-webdriver
echo "Install Gecko WebDriver for Firefox"
curl --location --silent --show-error "https://github.com/mozilla/geckodriver/releases/download/$GECKODRIVER_VERSION/geckodriver-$GECKODRIVER_VERSION-linux64.tar.gz" | tar -xz -C "$JMETER_BIN"
echo "webdriver.gecko.driver=$JMETER_BIN/geckodriver" >> "$JMETER_BIN/system.properties"
