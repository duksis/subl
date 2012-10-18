#!/bin/bash
. $(dirname $0)/support/assert.sh -v
. $(dirname $0)/../$(basename $0 _test.sh).sh --manual
. $(dirname $0)/support/helper.sh

## Linking subl executable to $PATH variable
_prepare
assert_raises "link_subl_executable_to_path" 1
echo "test" > "${_setting_directory}/fake_executable"; chmod +x "${_setting_directory}/fake_executable"
assert_raises "HOME=\"${_setting_directory}\"; link_subl_executable_to_path \"${_setting_directory}/fake_executable\"" 0
# subl in $HOME/bin
assert "ls -1 \"${_setting_directory}/bin/subl\"" "${_setting_directory}/bin/subl"
# Marked for removal
assert "ls -1 ${_setting_directory}/.sublime/uninstall_config.sh" "${_setting_directory}/.sublime/uninstall_config.sh"
_cleanup

## Linking user directory
_prepare
# should error out if no params provided
assert_raises "link_user_settings" 1
assert_raises "link_user_settings ${_setting_directory} ${_config}" 0
assert "ls -1 ${_setting_directory}/Packages/User" "${_setting_directory}/Packages/User"
_cleanup

## Installing Package Control
_prepare
assert_raises "install_package_control" 1
assert_raises "install_package_control \"${_setting_directory}\"" 0
_pkg_control="${_setting_directory}/Installed Packages/Package Control.sublime-package"
assert "ls -1 \"${_pkg_control}\"" "${_pkg_control}"
_cleanup

assert_end $(basename $0 _test.sh)
