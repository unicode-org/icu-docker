#!/bin/sh
if [ $# -ne 0 ];
then
    cd $1
    shift
fi

if [ ! -f  ./source/common/unicode/uversion.h ];
then
    echo "unknown-no-uversion"
    exit 1
fi
( grep -h "^#define U_ICU_VERSION " ./source/common/unicode/uvernum.h || echo unknown-no-define) | cut -d' ' -f3 | tr -d '"'
exit 0
