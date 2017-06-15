#!/bin/bash

DIRNAME=tl-`date +%Y_%m_%d_%H_%M_%S`

echo "make the install directory: $DIRNAME"
mkdir $DIRNAME
cd $DIRNAME

if [[ $TRAVIS_OS_NAME == 'osx' ]]; then
  curl -L -O http://ctan.math.washington.edu/tex-archive/systems/mac/mactex/BasicTeX.pkg
  sudo installer -pkg BasicTeX.pkg -target /
  rm BasicTeX.pkg
  export PATH=$PATH:/Library/TeX/texbin
else
  wget http://ctan.mirror.rafal.ca/systems/texlive/tlnet/install-tl-unx.tar.gz
  tar zxvf install-tl-unx.tar.gz
  cd install-tl-*
  cat << EOF > ./small.profile
selected_scheme scheme-small
TEXDIR $HOME/texlive/2017
TEXMFCONFIG $HOME/.texlive2017/texmf-config
TEXMFHOME $HOME/texmf
TEXMFLOCAL $HOME/texlive/texmf-local
TEXMFSYSCONFIG $HOME/texlive/2017/texmf-config
TEXMFSYSVAR $HOME/texlive/2017/texmf-var
TEXMFVAR $HOME/.texlive2017/texmf-var
binary_x86_64-linux 1
option_doc 0
option_src 0
EOF
  ./install-tl -profile ./small.profile -repository http://ctan.mirror.rafal.ca/systems/texlive/tlnet/
  export PATH=$PATH:$HOME/texlive/2017/bin/x86_64-linux
  tlmgr init-usertree
  cd ..
fi

cd ..

echo "remove the install directory"
rm -rf $DIRNAME
