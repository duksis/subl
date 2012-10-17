#!/bin/bash
. $(dirname $0)/support/assert.sh -v
# . $(dirname $0)/../$(basename $0 _test.sh).sh --manual
. $(dirname $0)/support/helper.sh

# assert "echo"
assert_end $(basename $0 _test.sh)
