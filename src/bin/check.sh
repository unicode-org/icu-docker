#!/bin/bash
. /src/bin/icu-dev.sh
set -x
if [ ! -f config.status ];
then
    icu-configure.sh || exit 1
fi

exec make -j${CORES} pcheck
