#!/bin/sh
# © 2019 and later: Unicode, Inc. and others.
# License & terms of use: http://www.unicode.org/copyright.html

. /src/bin/icu-dev.sh

set -x
if [ ! -f config.status ];
then
    icu-configure.sh --disable-tests --disable-extras || exit 1
fi


if [ -f /etc/os-release ];
then
    . /etc/os-release
fi
# the name of the dist/ directory
FN=icu-${ICU4CVER}-${REV}-$(bash /src/icu/icu4c/source/config.guess)-${NAME-${WHAT}}-${VERSION_ID-UNKNOWN}

rm -rf dist /dist/${FN}-src.d || true

# first, build
make -j${CORES} || exit 1

# now, source
if [ ${ICU4CMAJ} -lt 64 ];
then
    # use modified ICU 64 dist.mk
    make -C . -f /src/bin/dist_icu64.mk srcdir=/src/icu/icu4c/source top_srcdir=/src/icu/icu4c/source dist-local
else
    # by ICU 64, there's a reasonable make dist
    make dist
fi

mv -v dist /dist/${FN}-src.d

rm -rf doc

# make doc-searchengine

# #FN=icu-r$(svnversion /src/icu/ | tr -d ' ')-$(bash /src/icu/icu4c/source/config.guess)-${1:RANDOM}
# tar cfpz /dist/${FN}-sdoc.tgz ./doc || exit 1
#cd /dist
#md5sum ${FN}.tgz | tee ${FN}.tgz.md5

