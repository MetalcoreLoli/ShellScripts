#!/bin/sh

declare archs_path="$HOME/Sources/archs"
declare slackbuild_source="$HOME/Sources/"

declare arch_name=`echo -n "$1" | sed 's/https\:\/\/slackbuilds\.org\/slackbuilds\/14.2//' | sed 's/^[a-z]*\/[a-z]*\///g'`

declare pkg_name=`echo -n "$arch_name" | sed 's/\.tar\.[a-z]*//'`

cd ~/ && cd $archs_path
wget $1 && tar -xf $arch_name

mv $pkg_name $slackbuild_source && cd $slackbuild_source/$pkg_name 

sudo chmod +x "$pkg_name.SlackBuild"

echo  "$pkg_name was downloaded. download source code und inpkg"

