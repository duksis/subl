#!/bin/sh

end_ret=0
for test_suite in tests/*_test.sh; do
  ./$test_suite
  ret=$?; [ $ret -gt $end_ret ] && end_ret=$ret
done

exit $end_ret