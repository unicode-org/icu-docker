#!/bin/sh
# © 2016 and later: Unicode, Inc. and others.
# License & terms of use: http://www.unicode.org/copyright.html

. /src/bin/icu-dev.sh
set -x
if [ -f /etc/os-release ];
then
    . /etc/os-release
fi
FN=icu-r${REV-$(svnversion /src/icu/ | tr -d ' ')}-$(bash /src/icu/icu4c/source/config.guess)-${NAME-${WHAT}}-${VERSION_ID-UNKNOWN}
if [ ! -f config.status ];
then
    icu-configure.sh || exit 1
fi
rm -rf /tmp/icu
make -j${CORES} check && make -j${CORES} DESTDIR=/tmp/icu releaseDist || exit 1
#cp -v *-src-*.tgz /dist/${FN}-src.tgz || true
cd /tmp/
if [ -f /dist/${FN}.tgz ];
then
    mv /dist/${FN}.tgz /dist/${FN}-OLD.tgz
fi
tar cfpz /dist/${FN}.tgz ./icu || exit 1
cd /dist
md5sum ${FN}.tgz | tee ${FN}.tgz.md5

