#!/bin/bash
_setting_directory=$(dirname $0)/support/.testcase
_config="${_setting_directory}/config"
function _prepare {
  mkdir -p ${_config}
}
function _cleanup {
  rm -r ${_setting_directory}
}