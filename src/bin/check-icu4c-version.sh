#!/bin/sh
# © 2016 and later: Unicode, Inc. and others.
# License & terms of use: http://www.unicode.org/copyright.html

if [ $# -ne 0 ];
then
    cd $1
    shift
fi

if [ ! -f  source/common/unicode/uversion.h ];
then
    echo "unknown-no-uversion"
    exit 1
fi
( grep "^#define U_ICU_VERSION " source/common/unicode/uvernum.h || echo unknown-no-define) | cut -d' ' -f3 | tr -d '"'
exit 0
