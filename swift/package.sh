#!/bin/bash

rm -rf artifact
rm -rf .build
swift build -c release

mkdir artifact
mkdir artifact/piranha
cd artifact
mkdir piranha/bin
cp ../.build/release/Piranha /usr/local/bin/piranha

#cp -f .build/release/banner /usr/local/bin/banner
tar -zcvf piranha.tar.gz piranha
