#!/bin/bash

BUILD_DIR='../build'
DATE_STRING=$(date '+%Y_%m_%dT%H_%M_%S.')

# Kill the server if its up
echo "* Killing the server if it's up"
pkill nwserver-linux

# Remove Build Dir if it exists
echo "* Removing old build dir if it exists"
if [ -d "$BUILD_DIR" ]; then rm -Rf $BUILD_DIR; fi

# Make new build dir
echo "* Make new build dir"
mkdir $BUILD_DIR

# Build the mod from data
echo "* Building the mod from data"
/opt/wine-staging/bin/wine ../bin/ErfUtil.exe -1 -c ../build/alfa_050_moonshaes.mod -z ../data/*

# Rename the old mod with time stamp
if test -f ../../.local/share/Neverwinter\ Nights/modules/alfa_050_moonshaes.mod; then
	echo "* Backing up previous mod to alfa_050_moonshaes_$DATE_STRING.mod"
	mv ../../.local/share/Neverwinter\ Nights/modules/alfa_050_moonshaes.mod ../../.local/share/Neverwinter\ Nights/modules/alfa_050_moonshaes_$DATE_STRING.mod
fi

# Copy the new module over.
echo "* Copying new module over"
cp ../build/alfa_050_moonshaes.mod ../../.local/share/Neverwinter\ Nights/modules/alfa_050_moonshaes.mod

# Starting Server 
echo "* Starting Server"
screen -d -m ./start_nwn_server.sh