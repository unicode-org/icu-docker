#!/bin/bash


KEY=9731166CD8E23A83BEE7C6D3ACA5DBE1FD8FABF1
SHAFILE=icu4c-SHASUM512.txt
TOP=$(pwd)
LANG=C
for sub in dist/*;
do
    echo $sub
    VER=$(basename $sub | cut -d- -f2)
    echo $VER
    cd ${TOP}/${sub}
    if [ -f ${SHAFILE} ];
    then
        echo skipping due to ${SHAFILE}
    else
        echo in $VER
        echo summing icu4c-$(echo $VER | tr . _)-{src,data,docs}.{tgz,zip}
        shasum -a 512 icu4c-$(echo $VER | tr . _)-{src,data,docs}.{tgz,zip} > ${SHAFILE}
        echo verifying
        shasum -c icu4c-SHASUM512.txt || exit 1

        echo signing
        for file in icu4c-$(echo $VER | tr . _)-{src,data,docs}.{tgz,zip};
        do
            if [ -f ${file} ];
            then
                gpg --detach-sign -a -u ${KEY} ${file} || exit 1
            fi
        done
        gpg --clear-sign -a -u ${KEY} ${SHAFILE} 
    fi
done

