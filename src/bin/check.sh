#!/bin/bash
. /src/bin/icu-dev.sh
set -x
if [ ! -f config.status ];
then
    icu-configure.sh || exit 1
fi

# pcheck was added in 52.1
if [ ${ICU4CMAJ} -gt 51 ];
then
    VERB=pcheck
else
    VERB=check
fi

exec make -j${CORES} ${VERB}
