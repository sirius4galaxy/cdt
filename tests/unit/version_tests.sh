#!/bin/bash
set -eo pipefail
# The purpose of this test is to ensure that the output of the "flon-cpp --version" command matches the version string defined by our CMake files
echo '##### flon-cpp Version Label Test #####'
# orient ourselves
[[ -z "$BUILD_ROOT" ]] && export BUILD_ROOT="$(pwd)"
echo "Using BUILD_ROOT=\"$BUILD_ROOT\"."
# test expectations
if [[ -z "$EXPECTED" ]]; then
    if [[ -z "$1" ]]; then
        export VERSION="$(echo ${BUILDKITE_TAG:-$GIT_TAG} | sed "s/^v//")"
    else
        export VERSION="$1"
    fi
    export EXPECTED="flon-cpp version $VERSION"
fi
if [[ -z "$EXPECTED" ]]; then
    echo "Missing version input."
    exit 1
fi
echo "Expecting \"$EXPECTED\"..."
# get flon-cpp version
ACTUAL=$($BUILD_ROOT/bin/flon-cpp --version)
EXIT_CODE=$?
# verify 0 exit code explicitly
if [[ $EXIT_CODE -ne 0 ]]; then
    echo "flon-cpp produced non-zero exit code \"$EXIT_CODE\"."
    exit $EXIT_CODE
fi
# test version
if [[ "$EXPECTED" == "$ACTUAL" ]]; then
    echo "Passed with \"$ACTUAL\"."
    exit 0
fi
echo 'Failed!'
echo "\"$EXPECTED\" != \"$ACTUAL\""
exit 1
