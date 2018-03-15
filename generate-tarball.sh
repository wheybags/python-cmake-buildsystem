#!/bin/bash -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR

if [ $# -ne 1 ]; then
    echo usage $0 VERSION
fi

version=$1

if [ -e tarball_build_dir ]; then
    rm -rf tarball_build_dir
fi

if [ -e Python-$version ]; then
    rm -rf Python-$version
fi

mkdir tarball_build_dir
cd tarball_build_dir
cmake .. -DPYTHON_VERSION=$version -DUSE_HUNTER_LIBRARIES=Off
cd ..
rm -rf tarball_build_dir

tarball_name=python-$version.tar.gz
git ls-files | xargs tar -zcvf $tarball_name Python-$version
echo wrote tarball $tarball_name
