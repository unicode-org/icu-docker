#!/bin/sh
# © 2016 and later: Unicode, Inc. and others.
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
FN=icu-r${REV-$(svnversion /src/icu/ | tr -d ' ')}-$(bash /src/icu/icu4c/source/config.guess)-${NAME-${WHAT}}-${VERSION_ID-UNKNOWN}

rm -rf dist /dist/${FN}-src.d || true
make -j${CORES} && make dist

mv -v dist /dist/${FN}-src.d

rm -rf doc
make doc-searchengine

#FN=icu-r$(svnversion /src/icu/ | tr -d ' ')-$(bash /src/icu/icu4c/source/config.guess)-${1:RANDOM}
tar cfpz /dist/${FN}-sdoc.tgz ./doc || exit 1
#cd /dist
#md5sum ${FN}.tgz | tee ${FN}.tgz.md5

