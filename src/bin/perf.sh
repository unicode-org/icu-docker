#!/bin/sh
# © 2016 and later: Unicode, Inc. and others.
# License & terms of use: http://www.unicode.org/copyright.html

. /src/bin/icu-dev.sh

build.sh || exit 1
cat >test/perf/howExpensiveIs/Makefile.local <<EOF
CPPFLAGS+=-DSKIP_DATEFMT_TESTS=1 -DSKIP_NUMPARSE_TESTS=1 -DSKIP_NUMFORMAT_TESTS -DSKIP_NUM_OPEN_TEST -DUCONFIG_NO_CONVERSION=1 -DU_LOTS_OF_TIMES=1000000 -DSKIP_URES_OPEN_TEST
EOF

make -C test/perf/howExpensiveIs all check || exit 1
cp -v test/perf/howExpensiveIs/howexpensive.xml /dist/howexpensive-${1:-unknown$RANDOM}.xml || exit 1
ccache -s

