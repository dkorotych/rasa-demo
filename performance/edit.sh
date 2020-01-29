#!/usr/bin/env bash

set -e
set -u

JMETER_BIN="$(dirname $(readlink -f $0))/jmeter/bin"

if [ -d "$JMETER_BIN" ]; then
  "$JMETER_BIN/jmeter.sh" --testfile "$JMETER_BIN/../../Performance.jmx"
else
  echo "Application not found. Please execute $(dirname prepare.sh)/prepare.sh"
fi
