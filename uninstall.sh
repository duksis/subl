#!/bin/sh

sudo rm -fr "/Applications/Sublime Text 2.app"

if [ -f "$HOME/.sublime/uninstall_config.sh" ]; then
  source $HOME/.sublime/uninstall_config.sh
fi
rm -fr $HOME/.sublime

source $HOME/.bash_profile
