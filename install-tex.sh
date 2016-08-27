#!/bin/bash

if [[ $TRAVIS_OS_NAME == 'osx' ]]; then
  curl -L -O http://mirrors.concertpass.com/tex-archive/systems/mac/mactex/BasicTeX.pkg
  sudo installer -pkg BasicTeX.pkg -target /
  rm BasicTeX.pkg
  export PATH=$PATH:/usr/texbin
else
  sudo add-apt-repository -y ppa:jonathonf/texlive-2016
  sudo apt-get update -qq
  sudo apt-get install -y texlive xzdec
  tlmgr init-usertree
fi
