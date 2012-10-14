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

# Configuring sublime
XSUBL_EXECUTABLE=${XSUBL_EXECUTABLE:-/Applications/Sublime\ Text\ 2.app/Contents/SharedSupport/bin/subl}
XSUBL_CONFIG=${XSUBL_CONFIG:-$HOME/Library/Application\ Support/Sublime\ Text\ 2}
XSUBL_PKGS=${XSUBL_CONFIG:?}/Packages
XSUBL_INSTALLED_PKGS=${XSUBL_CONFIG:?}/Installed\ Packages
XSUBL_CONFIG_SOURCE=${CONFIG:-"git://github.com/duksis/sublime-settings.git"}
XSUBL_CONFIG_TARGET=$HOME/.config/sublime-text-2

function mark_for_uninstall {
	mkdir -p $HOME/.sublime
  echo "rm $1" >> $HOME/.sublime/uninstall_config.sh
}

# Add subl executable into a PATH directory
if [ -f "${XSUBL_EXECUTABLE}" ]; then  #&& [ -n "$(which subl)" ]; then
  mkdir -p $HOME/bin
  ln -sv "${XSUBL_EXECUTABLE}" $HOME/bin/subl

  mark_for_uninstall "$HOME/bin/subl"
fi

# Sublime user setting
if [ -d "${XSUBL_CONFIG_DIR}" ]; then
  mv "${XSUBL_CONFIG_DIR}" "${XSUBL_CONFIG_DIR}.default"
fi

mkdir -p "$XSUBL_PKGS"

if [ -d "${XSUBL_CONFIG_SOURCE}" ]; then
  ln -shvf "${XSUBL_CONFIG_SOURCE}" "${XSUBL_PKGS}/User"
else
  git clone "${XSUBL_CONFIG_SOURCE}" "${XSUBL_PKGS}/User"
fi

# Install package control
wget -P /tmp/ http://sublime.wbond.net/Package%20Control.sublime-package
mkdir -p "${XSUBL_INSTALLED_PKGS}"
mv "/tmp/Package Control.sublime-package" "${XSUBL_INSTALLED_PKGS}/"

# Reload shel
source $HOME/.bash_profile
