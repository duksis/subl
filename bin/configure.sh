#!/bin/sh
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
