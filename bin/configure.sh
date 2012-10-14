#!/bin/sh
XSUBLIME_EXECUTABLE=${XSUBLIME_EXECUTABLE:-/Applications/Sublime\ Text\ 2.app/Contents/SharedSupport/bin/subl}
XSUBLIME_CONFIG=${XSUBLIME_CONFIG:-$HOME/Library/Application\ Support/Sublime\ Text\ 2}
XSUBLIME_PKGS=${XSUBLIME_CONFIG:?}/Packages
XSUBLIME_INSTALLED_PKGS=${XSUBLIME_CONFIG:?}/Installed\ Packages
XSUBLIME_CONFIG_SOURCE=${CONFIG:-"git://github.com/duksis/sublime-settings.git"}
XSUBLIME_CONFIG_TARGET=$HOME/.config/sublime-text-2

function mark_for_uninstall {
	mkdir -p $HOME/.sublime
  echo "rm $1" >> $HOME/.sublime/uninstall_config.sh
}

# Add subl executable into a PATH directory
if [ -f "${XSUBLIME_EXECUTABLE}" ]; then  #&& [ -n "$(which subl)" ]; then
  mkdir -p $HOME/bin
  ln -sv "${XSUBLIME_EXECUTABLE}" $HOME/bin/subl

  mark_for_uninstall "$HOME/bin/subl"
fi

# Sublime user setting
if [ -d "${XSUBLIME_CONFIG_DIR}" ]; then
  mv "${XSUBLIME_CONFIG_DIR}" "${XSUBLIME_CONFIG_DIR}.default"
fi

if [ -d "${XSUBLIME_CONFIG_TARGET}" ]; then
  echo "Sublime configuration already pressent at '${XSUBLIME_CONFIG_TARGET}'"
else
  mkdir -p "${XSUBLIME_CONFIG_TARGET}"
  mark_for_uninstall "-fr ${XSUBLIME_CONFIG_TARGET}"
  git clone "${XSUBLIME_CONFIG_SOURCE}" "${XSUBLIME_CONFIG_TARGET}"
fi
mkdir -p "$XSUBLIME_PKGS"
ln -shvf "${XSUBLIME_CONFIG_TARGET}" "${XSUBLIME_PKGS}/User"

# Install package control
wget -P /tmp/ http://sublime.wbond.net/Package%20Control.sublime-package
mv "/tmp/Package Control.sublime-package" "${XSUBLIME_INSTALLED_PKGS}"
