#!/usr/bin/env bash

set -e
set -u

CURRENT_DIRECTORY=$(pwd)
REPORT="$(dirname $(readlink -f $0))/report"
JMETER_BIN="$(dirname $(readlink -f $0))/jmeter/bin"

if [ -d "$JMETER_BIN" ]; then
  mkdir -p "$REPORT/temp"
  cd "$REPORT"
  "$JMETER_BIN/jmeter.sh" \
    --nongui \
    --testfile "$REPORT/../Performance.jmx" \
    --logfile result.csv \
    --forceDeleteResultFile \
    --reportatendofloadtests

  rm -f -r "$REPORT/report-output"
  mv "$JMETER_BIN/report-output" "$REPORT/"

  xdg-open "$REPORT/report-output/index.html"

  cd "$CURRENT_DIRECTORY"
else
  echo "Application not found. Please execute $(dirname prepare.sh)/prepare.sh"
fi
