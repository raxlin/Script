#!/bin/bash

# sudo apt-get install lame icedax
LIBRARY_PKG=("lame" "icedax");

Script_Folder=`pwd`;
Default_Folder='/mnt/music/';

function check_pkg() {
	for PKG in ${LIBRARY_PKG[@]} ; 
	do
		RESULT=`dpkg --get-selections | awk '{print $1}' | grep -E ^$PKG$`;
		if [ -z "$RESULT" ] ; then
			echo "install pkg: $PKG before copy the CD.";
			sudo apt-get install $PKG;
		fi
	done
}

function check_default_folder() {
	if [ ! -d "$Default_Folder" ] ; then
		sudo mkdir $Default_Folder;
	fi
}

check_pkg

cd $Default_Folder;

echo "Please input the CD Name : ";
read folder_name;
if [ ! -d $folder_name ] ; then
	mkdir -p $folder_name
fi

cd $folder_name

cdda2mp3 $folder_name
eject

cd $Script_Folder;
