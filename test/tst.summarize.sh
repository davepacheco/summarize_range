#!/bin/bash

#
# tst.summarize.sh: runs a bunch of tests for "summarize_range", including both
# valid and invalid input.  This is run by "catest", which compares the stdout
# to known-good stdout.
#

prog="$(dirname "${BASH_SOURCE[0]}")/../summarize_range"

#
# Special cases
#

echo "test: empty input"
$prog < /dev/null
echo $?

#
# Single-range inputs
#

echo "test: basic sequence (5-10)"
seq 5 10 | $prog
echo $?

echo "test: basic value (7)"
echo 7 | $prog
echo $?

#
# Multiple-range inputs
#

echo "test: complex multiple-range input"
(echo 3; seq 7 12; echo 15; echo 17; echo 18; seq 31 42) | $prog
echo $?

#
# Bad input: too many fields
#
echo "test: too many fields (line 1)"
(echo "3 4"; echo 7; seq 1 10) | $prog
echo $?

echo "test: too many fields (after emitting some ranges)"
(seq 5 10; echo 12; echo 14 15; seq 18 31) | $prog
echo $?

#
# Bad input: unsorted input
#
echo "test: unsorted input (line 1)"
(echo 100; echo 99) | $prog
echo $?

echo "test: unsorted input (after emitting some ranges)"
(seq 88 94; echo 97; echo 100; echo 99) | $prog
echo $?

#
# Bad input: bad values
#
echo "test: 0 value"
echo 0 | $prog
echo $?

echo "test: negative value"
echo -5 | $prog
echo $?

echo "test: trailing characters"
(echo 12; echo 13; echo 16; echo 32.stor.example.com) | $prog
echo $?

#
# Large input tests
#
echo "test: large input (1 to 10,000,001)"
seq -f %.0f 1 10000001 | $prog
echo $?

echo "test: large input (10,000,001 to 20,000,001)"
seq -f %.0f 10000001 20000001 | $prog
echo $?
