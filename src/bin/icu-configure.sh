#!/bin/bash
# © 2016 and later: Unicode, Inc. and others.
# License & terms of use: http://www.unicode.org/copyright.html

. /src/bin/icu-dev.sh
if [ $ICU4CMAJ = 58 ];
then
    # workaround for xlocale
    CONFIGSTUFF="CPPFLAGS=-DU_USE_STRTOD_L=0"
elif [ $ICU4CMAJ = 59 ];
then
    # workaround for xlocale
    CONFIGSTUFF="CPPFLAGS=-DU_USE_STRTOD_L=0"
else
    CONFIGSTUFF=
fi

echo configure options $CONFIGSTUFF $EXTRACONFIGSTUFF

exec ${SHELL} /src/icu/icu4c/source/configure $CONFIGSTUFF $EXTRACONFIGSTUFF $* || (tail config.log ; exit 1)

