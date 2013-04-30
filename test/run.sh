#!/bin/bash

# bail on error
set -e

DIR=$( cd $( dirname "${BASH_SOURCE[0]}" ) && pwd )

# Note: dart_analyzer needs to be run from the root directory for proper path
# canonicalization.
pushd $DIR/..
echo Analyzing web/app.dart
dart_analyzer --fatal-warnings --fatal-type-errors web/app.dart \
  || echo -e "Ignoring analyzer errors"

rm -rf out/*
popd
