#!/bin/bash

XSUBL_CONFIG=${XSUBL_CONFIG:-$HOME/Library/Application\ Support/Sublime\ Text\ 2}
XSUBL_EXECUTABLE=${XSUBL_EXECUTABLE:-"/Applications/Sublime Text 2.app/Contents/SharedSupport/bin/subl"}
XSUBL_CONFIG_TARGET=$HOME/.config/sublime-text-2
if [ "$XSUBL_CONFIG_SOURCE" == "" ] && [ -d "$XSUBL_CONFIG_TARGET" ]; then
  XSUBL_CONFIG_SOURCE=$XSUBL_CONFIG_TARGET
fi


args="$(getopt -n "$0" -l help,manual,configure hmc $*)" \
|| exit -1
for arg in $args; do
    case "$arg" in
        -h)
            echo "$0 [-mc] [--manual] [--configure]"
            echo "`sed 's/./ /g' <<< "$0"` [-h] [--help]"
            exit 0;;
        --help)
            cat <<EOF
Usage: $0 [options]
One line Sublime Text 2 installer.

Options:
  -m, --manual            loads functions for manual execution
  -c, --configure <PATH>  configure Sublime (a path/url to configuration should be provided)
  -h                      show brief usage information and exit
  --help                  show this help message and exit
EOF
            exit 0;;
        -m|--manual)
            MANUAL=1;;
        -c|--configure)
            CONFIG=$OPTARG;;
    esac
done

## Helpers
function mark_for_uninstall {
	mkdir -p $HOME/.sublime
  echo "rm $1" >> $HOME/.sublime/uninstall_config.sh
}

function should_install {
  [ "$MANUAL" != "1" ]
}


## Sublime Text 2
# Downloads, mounts and moves sublime to application dir
function install_sublime {
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
}

## Configuring Sublime Text 2
# Add subl executable into a PATH directory
function link_subl_executable_to_path {
  _executable=${1:?}
  if [ -f "${_executable}" ]; then
    mkdir -p $HOME/bin
    ln -sv "${_executable}" $HOME/bin/subl

    mark_for_uninstall "$HOME/bin/subl"
  fi
}

# Sublime user setting
function link_user_settings {
  pkg_dir="${1:?}/Packages"
  config="${2:?}"

  if [ -d "${pkg_dir}/User" ]; then
    mv "${pkg_dir}/User" "${pkg_dir}/User.default"
  fi

  mkdir -p "$pkg_dir"

  if [ -d "${config}" ]; then
    ln -shf "${config}" "${pkg_dir}/User"
  else
    git clone "${config}" "${pkg_dir}/User"
  fi
}

# Install package control
function install_package_control {
  _installed_pkgs=${1:?}/Installed\ Packages
  wget -P /tmp/ http://sublime.wbond.net/Package%20Control.sublime-package
  mkdir -p "${_installed_pkgs}"
  mv "/tmp/Package Control.sublime-package" "${_installed_pkgs}/"
}

# Reloade shell for changes to take place
function reload_shell {
  source $HOME/.bash_profile
}

if should_install; then
  install_sublime

  link_subl_executable_to_path "$XSUBL_EXECUTABLE"

  [ "${CONFIG:-$XSUBL_CONFIG_SOURCE}" != "" ] && link_user_settings "$XSUBL_CONFIG" "${CONFIG:-$XSUBL_CONFIG_SOURCE}"

  install_package_control "$XSUBL_CONFIG"

  reload_shell
fi
