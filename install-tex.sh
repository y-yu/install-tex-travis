#!/bin/bash

DIRNAME=tl-`date +%Y_%m_%d_%H_%M_%S`

echo "make the install directory: $DIRNAME"
mkdir $DIRNAME
cd $DIRNAME

if [[ $TRAVIS_OS_NAME == 'osx' ]]; then
  curl -L -O http://mirrors.concertpass.com/tex-archive/systems/mac/mactex/BasicTeX.pkg
  sudo installer -pkg BasicTeX.pkg -target /
  rm BasicTeX.pkg
  export PATH=$PATH:/usr/texbin
else
  wget https://raw.githubusercontent.com/scottkosty/install-tl-ubuntu/master/install-tl-ubuntu && chmod +x ./install-tl-ubuntu
  wget https://raw.githubusercontent.com/y-yu/install-tex-travis/master/small.profile
  sudo ./install-tl-ubuntu -p `pwd`/small.profile -q http://ctan.mirror.rafal.ca/systems/texlive/tlnet/
  export PATH=$PATH:/opt/texbin
  tlmgr init-usertree
fi

cd ..

echo "remove the install directory"
sudo rm -rf $DIRNAME
