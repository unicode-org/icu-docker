#!/bin/bash
# © 2016 and later: Unicode, Inc. and others.
# License & terms of use: http://www.unicode.org/copyright.html
git config --global --add safe.directory /src/icu

. /src/bin/icu-dev.sh
exec ${SHELL} /src/icu/icu4c/source/configure $*
