#!/bin/bash

if [[ $TRAVIS_OS_NAME == 'osx' ]]; then
  sudo tlmgr $@
else
  sudo env "PATH=$PATH" tlmgr $@
fi
