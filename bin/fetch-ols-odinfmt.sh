#!/bin/bash

# version="refs/heads/master"
version="e2f4f96cd46b70360f3caa58acc4af14eb0e8688"
bin_dir="bin"
name="ols"

tarball_remote_file="${version}.tar.gz"
tarball_dir="${name}-${version}"

tarball_url="https://github.com/DanielGavin/ols/archive/${tarball_remote_file}"
tarball_local_file="${name}-${tarball_remote_file}"
tarball_path="${bin_dir}/${tarball_local_file}"
tarball_dir="${bin_dir}/${tarball_dir}"

if [ ! -f $tarball_path ]; then
	echo "Downloading: ${tarball_url}"
	curl -s -L $tarball_url -o $tarball_path
fi

if [ ! -d $tarball_dir ]; then
	tar -xzf $tarball_path -C $bin_dir
fi

pushd $tarball_dir > /dev/null

echo "ols build..."
./build.sh
mv ols ..

echo "odinfmt build..."
./odinfmt.sh
mv odinfmt ..

popd > /dev/null

rm -rf $tarball_dir
rm -f $tarball_path
