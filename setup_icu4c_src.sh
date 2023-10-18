#!/bin/bash
set -e

# Get ICU source and prepare for `make dist`
# RELEASE_BRANCH must be set to the desired Github branch of unicode/icu.
if [ -z "$RELEASE_BRANCH" ]; then
   echo "RELEASE_BRANCH is not set."
   exit 1
fi

echo "Release branch is" $RELEASE_BRANCH
cd src
rm -rf icu

git clone --branch $RELEASE_BRANCH --depth 1 https://github.com/unicode-org/icu.git
cd icu
git lfs install --local
git lfs fetch
git lfs checkout

# Change LICENSE link to actual LICENSE file in icu4c.
if [ -L icu4c/LICENSE ]; then
  rm icu4c/LICENSE;
  cp -p LICENSE icu4c/LICENSE
  echo "Replaced LICENSE link with real file"
else
  echo "LICENSE was actual file"
fi

cd ../..
