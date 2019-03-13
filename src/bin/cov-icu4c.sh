#!/bin/sh

PROJ=icu4c
COVDIR=/src/bin/cov-analysis-linux64/
#  much of the rest is common to C and J - except build and auth
if [ ! -x /src/bin/local-coverity.sh ];
then
    echo missing /src/bin/local-coverity.sh
    exit 1
fi
. /src/bin/local-coverity.sh
if [ ! -d ${COVDIR} ];
then
    echo missing coverity dir ${COVDIR}
    exit 1
fi

export PATH=${COVDIR}/bin:${PATH}
export WORKSPACE=$(pwd)
export SRCDIR=/src/icu/${PROJ}
BLDDIR=${WORKSPACE}/build/${PROJ}.build.cov
echo building ${SRCDIR} in ${BLDDIR}
rm -rf ${BLDDIR} ; mkdir -p ${BLDDIR}
VERFILE=${SRCDIR}/source/common/unicode/uvernum.h
# Get the ICU version from uversion.h or other headers
geticuversion() {
    sed -n 's/^[ 	]*#[ 	]*define[ 	]*U_ICU_VERSION[ 	]*"\([^"]*\)".*/\1/p' "$@"
}
ICUVER=`geticuversion ${VERFILE}`
SVN_REVISION=$(cd ${SRCDIR} >/dev/null && (git describe --tags --exact-match 2>/dev/null || git rev-parse --short HEAD) || echo 'unknown')
echo $ICUVER $SVN_REVISION
cd ${BLDDIR}
# C specific build
${SRCDIR}/source/configure --disable-renaming --disable-extras --with-data-packaging=archive
env COVERITY_UNSUPPORTED=1 ${COVDIR}/bin/cov-build --dir cov-int make || exit 1
fgrep '[WARNING] No files were emitted' cov-int/build-log.txt  && exit 1
tar cfpz ${PROJ}.tgz cov-int &&
ls -lh ${PROJ}.tgz &&
curl --form token=${COVERITY_TOKEN} \
     --form email=${COVERITY_EMAIL} \
     --form file=@${PROJ}.tgz \
     --form version="${ICUVER}" \
     --form description="Manual submit from ${COVERITY_EMAIL} ${SVN_REVISION}" \
     https://scan.coverity.com/builds?project=${PROJ} -o form-submit.$$
cat form-submit.$$ || exit 1
echo uploaded r${SVN_REVISION} ${PROJ} ${ICUVER} as ${PROJ}.tgz
echo done
exit 0


