#!/bin/bash

# version="refs/heads/master"
version="46892948312c14b44600ae9f557e86bd8c792343"

tarball_url="https://github.com/DanielGavin/ols/archive/${version}.tar.gz"
tarball_name="ols.tar.gz"

echo "Downloading: ${tarball_url}"
curl -s -L $tarball_url -o $tarball_name

tar -xzf $tarball_name -C bin
mv bin/ols-* bin/ols

pushd bin/ols > /dev/null

./odinfmt.sh
mv odinfmt ..

popd > /dev/null

rm -rf bin/ols
rm -f $tarball_name