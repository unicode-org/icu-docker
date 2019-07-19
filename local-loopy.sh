#!/bin/sh

HERE=$(pwd)
ICU=${HERE}/src/icu
MAINTS=$(cd ${ICU} >/dev/null ; git for-each-ref --format='%(refname)' refs/remotes/origin/maint  | cut -d/ -f3-)

for maint in $MAINTS;
do
    echo $maint
    if [ -f  $(basename ${maint}).log ];
    then
        echo "skipping…"
    else
        cd ${ICU}
        git reset --hard HEAD # try to unstick
        git clean -d -f -x
        git checkout $maint || exit 1
        cd ${HERE}
        make src-one 2>&1 | tee $(basename ${maint}).log
    fi
done

