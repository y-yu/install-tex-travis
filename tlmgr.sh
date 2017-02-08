#!/bin/bash

if [[ $TRAVIS_OS_NAME == 'osx' ]]; then
  sudo tlmgr $@
else
  tlmgr $@
fi
