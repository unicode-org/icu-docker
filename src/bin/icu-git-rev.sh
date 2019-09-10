#!/bin/sh
# © 2018 and later: Unicode, Inc. and others.
# License & terms of use: http://www.unicode.org/copyright.html

if ! command -v git > /dev/null 2>&1 ; then
    echo 'git-not-installed'
    exit 1
fi

DIR=${1:-/src/icu}
cd ${DIR} >/dev/null || exit 1

echo $(git rev-parse --short HEAD)
exit 0
