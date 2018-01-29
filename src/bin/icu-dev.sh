#!/bin/bash
# © 2016 and later: Unicode, Inc. and others.
# License & terms of use: http://www.unicode.org/copyright.html

# setup some vars
export CORES=$(grep -c ^processor /proc/cpuinfo)
export PATH=/src/bin:${PATH}

# colored output doesn't work as well from here
export TERM=
