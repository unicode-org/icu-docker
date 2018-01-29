#!/bin/bash
# © 2016 and later: Unicode, Inc. and others.
# License & terms of use: http://www.unicode.org/copyright.html

. /src/bin/icu-dev.sh

set -x
if [ ! -f config.status ];
then
    icu-configure.sh || exit 1
fi
ccache -s
( make -j${CORES} && make -C tools/icuinfo check  )  || exit 1
ccache -s
