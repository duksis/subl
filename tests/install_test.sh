#!/bin/bash
. $(dirname $0)/support/assert.sh

assert "echo" "test"
assert_end $(basename $0 _test.sh)
