#!/bin/bash

# Sort out the /dist folder, which is somewhat of a mess.
# Ideally `make dist` would do this. But until then.
cd ./dist || exit 1

# now get a list of stuff
STUFF=$(find icu-* -type f \( -name '*.zip' -o -name '*.tgz' \))

trymove()
{
    base2=$(basename $1)
    if [ -f ${2}/${3} ];
    then
        echo "# exists: ${2}/${3} (not copying $base2)"
    else
        mkdir -p ${2}
        ln -v ${1} ${2}/${3}
    fi
}

for file in ${STUFF};
do
    #echo "# ${file}"
    base=$(basename $file)
    # rver is '66-1' or '66-rc'
    rver=$(echo $file | grep "^icu-rrelease-[0-9][0-9]-[0-9rc]" | cut -d- -f3-4)

    # The version of the file
    mainver="icu4c-"$(echo $file | grep "^icu-rrelease-[0-9][0-9]-[0-9rc]" | cut -d- -f3)"_1"
    if [ "${rver}" = "" ];
    then
        echo "# ${file} - could not extract release version."
        continue
    fi
    uver=$(echo $rver | tr - _)
    prefix=icu4c-${uver}
    dir=icu4c-$(echo $rver | tr - .)
    mkdir -pv ./${dir}/

    
    # echo $base
    case $base in
        *-sdoc.tgz)
            trymove ${file} ${dir} SOURCEDOC-${prefix}-SOURCEDOC.tgz
            ;;
        *-Fedora*.tgz|*-Ubuntu-*.tgz)
            # e.g., icu-rrelease-66-1-x86_64-pc-linux-gnu-Ubuntu-18.04.tgz
            arch=$(basename $file | cut -d - -f5)
            case $arch in
                x86_64) arch="x64" ;;
                *) ;;
            esac
            sys=$(basename $file .tgz | cut -d - -f9,10 | tr -d - )
            outname=${prefix}-${sys}-${arch}.tgz
            trymove ${file} ${dir} ${outname} 
            ;;


        ${mainver}-docs.zip|${mainver}-src.tgz|${mainver}-src.zip|${mainver}-data.zip|${mainver}-data-bin-b.zip|${mainver}-data-bin-l.zip)
          # Only if the version is not the same as the .zip file's name
          if [ "$mainver" != "$prefix" ]; 
          then
            # Has the name with the final release version. Change to the actual release name
            newname=${base/$mainver/$prefix}
            trymove ${file} ${dir} ${newname}
          fi
          ;;

        ${prefix}-docs.zip|${prefix}-src.tgz|${prefix}-src.zip|${prefix}-data.zip|${prefix}-data-bin-b.zip|${prefix}-data-bin-l.zip)
            # already has the right name so move it to the output area
            trymove ${file} ${dir} ${base}
            ;;

        icu4c-${uver}-*)
            # ignore anything else with uver
            echo "# Ignored: ${base}"
            ;;
        *):
            echo "## Warn: could not classify ${base}"
            ;;
    esac
done
