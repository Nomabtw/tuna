#!/bin/sh
# Automatic packaging for mac builds

echo "Preparing 64bit build"
bits="64"

version=$1
data_dir="../data"
project="tuna"
arch="mac"
qt_version="5_14_2"
build_location="../../../../build-obs-studio-Qt_${qt_version}_${qt_version}-RelWithDebInfo/rundir/RelWithDebInfo/obs-plugins"
build_dir=$project.v$version.$arch

if [ -z "$version" ]; then
	echo "Please provide a version string"
	exit
fi

# Yanked from obs-mac-virtualcam, fixes QT runtime dps
install_name_tool \
  -change $(brew --prefix qt5)/lib/QtWidgets.framework/Versions/5/QtWidgets \
    @executable_path/../Frameworks/QtWidgets.framework/Versions/5/QtWidgets \
  -change $(brew --prefix qt5)/lib/QtGui.framework/Versions/5/QtGui \
    @executable_path/../Frameworks/QtGui.framework/Versions/5/QtGui \
  -change $(brew --prefix qt5)/lib/QtCore.framework/Versions/5/QtCore \
    @executable_path/../Frameworks/QtCore.framework/Versions/5/QtCore \
  $build_location/${project}.so

echo "Creating build directory"
mkdir -p $build_dir/$project
mkdir -p $build_dir/$project/bin

echo "Fetching build from $build_location"
cp $build_location/$project.so $build_dir/$project/bin

echo "Fetching locale from $data_dir"
cp -R $data_dir $build_dir/$project

echo "Fetching misc files"
cp ./README $build_dir/README.txt
cp ../LICENSE $build_dir/LICENSE.txt
cp ./install-mac.sh $build_dir/

echo "Writing version number $version and project id $project"
sed -i -e "s/@VERSION/$version/g" ./README
sed -i -e "s/@PROJECT/$project/g" ./README-e
rm $build_dir/README.txt
mv ./README-e-e $build_dir/README.txt

echo "Zipping to $project.v$version.$arch.zip"
cd $build_dir
zip -r "../$project.v$version.$arch.zip" ./ 
cd ..

echo "Cleaning up"
rm -rf $build_dir
rm -rf README-e
