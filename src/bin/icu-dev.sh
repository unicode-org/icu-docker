#!/bin/bash
# © 2016 and later: Unicode, Inc. and others.
# License & terms of use: http://www.unicode.org/copyright.html

# setup some vars
export CORES=$(grep -c ^processor /proc/cpuinfo)
export PATH=/src/bin:${PATH}
export ICU4CVER=$(/src/bin/check-icu4c-version.sh /src/icu/icu4c)
export ICU4CMAJ=$(echo ${ICU4CVER} | cut -d. -f1)

# colored output doesn't work as well from here
export TERM=
