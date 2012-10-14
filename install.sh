#!/bin/bash

# download image
wget -P /tmp/ http://c758482.r82.cf2.rackcdn.com/Sublime%20Text%202.0.1.dmg

# mount image
hdiutil attach "/tmp/Sublime Text 2.0.1.dmg"

# coppy it to application folder
sudo cp -r "/Volumes/Sublime Text 2/Sublime Text 2.app" "/Applications/"

# unmount image
hdiutil detach "/Volumes/Sublime Text 2"

# remove image
rm "/tmp/Sublime Text 2.0.1.dmg"

source bin/configure.sh

source $HOME/.bash_profile