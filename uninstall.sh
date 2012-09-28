#!/bin/sh

sudo rm -fr "/Applications/Sublime Text 2.app"

source $HOME/.sublime/uninstall_config.sh
rm -fr $HOME/.sublime

source $HOME/.bash_profile
