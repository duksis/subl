#!/bin/bash
. $(dirname $0)/support/assert.sh -v

assert "echo"
assert_end $(basename $0 _test.sh)
