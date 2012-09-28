#!/bin/sh
XSUBLIME_EXECUTABLE="/Applications/Sublime Text 2.app/Contents/SharedSupport/bin/subl"

# Add subl executable into a PATH directory
if [ -f "${XSUBLIME_EXECUTABLE}" ]; then
  mkdir -p $HOME/bin
  ln -s "${XSUBLIME_EXECUTABLE}" $HOME/bin/subl
  mkdir -p $HOME/.sublime
  echo "rm $HOME/bin/subl" >> $HOME/.sublime/uninstall_config.sh
fi
