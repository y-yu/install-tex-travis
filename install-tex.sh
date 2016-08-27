#!/bin/bash

if [[ $TRAVIS_OS_NAME == 'osx' ]]; then
  curl -L -O http://mirrors.concertpass.com/tex-archive/systems/mac/mactex/BasicTeX.pkg
  sudo installer -pkg BasicTeX.pkg -target /
  rm BasicTeX.pkg
  export PATH=$PATH:/usr/texbin
else
  wget https://github.com/scottkosty/install-tl-ubuntu/raw/master/install-tl-ubuntu && chmod +x ./install-tl-ubuntu
  wget https://github.com/y-yu/install-tex-travis/raw/master/small.profile
  sudo ./install-tl-ubuntu -p `pwd`/small.profile -q http://ctan.mirror.rafal.ca/systems/texlive/tlnet/
  export PATH=$PATH:/opt/texbin
  tlmgr init-usertree
fi
