#!/bin/bash

# Comment out to avoid an error on macOS
# set -e

DIRNAME=tl-`date +%Y_%m_%d_%H_%M_%S`

echo "make the install directory: $DIRNAME"
mkdir $DIRNAME
cd $DIRNAME

wget http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
tar zxvf install-tl-unx.tar.gz
cd install-tl-2020*/

BASE_PROFILE=$(cat << EOS
selected_scheme scheme-small
TEXDIR $HOME/texlive
TEXMFCONFIG $HOME/.texlive/texmf-config
TEXMFHOME $HOME/texmf
TEXMFLOCAL $HOME/texlive/texmf-local
TEXMFSYSCONFIG $HOME/texlive/texmf-config
TEXMFSYSVAR $HOME/texlive/texmf-var
TEXMFVAR $HOME/.texlive/texmf-var
option_doc 0
option_src 0
EOS
)

if [[ $TRAVIS_OS_NAME == 'osx' ]]; then
  echo "$BASE_PROFILE\nbinary_x86_64-darwin 1" > ./small.profile
  export PATH=$PATH:$HOME/texlive/bin/x86_64-darwin
else
  echo "$BASE_PROFILE\nbinary_x86_64-linux 1" > ./small.profile
  export PATH=$PATH:$HOME/texlive/bin/x86_64-linux
fi

chmod +x ./install-tl
./install-tl -profile ./small.profile -repository http://ctan.mirror.rafal.ca/systems/texlive/tlnet
tlmgr init-usertree

cd ../..

echo "remove the install directory"
rm -rf $DIRNAME
