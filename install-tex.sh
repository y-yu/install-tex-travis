#!/bin/bash

# Comment out to avoid an error on macOS
# set -e
set -x

DIRNAME=tl-`date +%Y_%m_%d_%H_%M_%S`

if [[ "$TRAVIS_OS_NAME" == 'osx' ]]; then
  export PATH=$PATH:$HOME/texlive/bin/x86_64-darwin
elif [[ "$TRAVIS_OS_NAME" == 'windows' ]]; then
  export PATH=$PATH:$HOME/texlive/bin/win32
else
  export PATH=$PATH:$HOME/texlive/bin/x86_64-linux
fi

# Check if the texlive directory has been or not.
# If a user would use cache the directory could be there.
if [ ! -z "`ls -A $HOME/texlive`" ]; then
  echo "${HOME}/texlive has already existed so skipped to install"
  return 0
fi

echo "make the install directory: $DIRNAME"
mkdir $DIRNAME
cd $DIRNAME

if [[ "$TRAVIS_OS_NAME" == 'windows' ]]; then
  curl -L -O http://mirror.ctan.org/systems/texlive/tlnet/install-tl.zip
  unzip install-tl.zip
else
  curl -L -O http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
  tar zxvf install-tl-unx.tar.gz
fi

cd install-tl-2020*/

cat << EOS > ./small.profile
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

if [[ "$TRAVIS_OS_NAME" == 'osx' ]]; then
  echo "binary_x86_64-darwin 1" >> ./small.profile
elif [[ "$TRAVIS_OS_NAME" == 'windows' ]]; then
  echo "binary_win32 1" >> ./small.profile
else
  echo "binary_x86_64-linux 1" >> ./small.profile
fi

if [[ "$TRAVIS_OS_NAME" == 'windows' ]]; then
  echo y | ./install-tl-windows.bat -profile ./small.profile -repository http://ctan.mirror.rafal.ca/systems/texlive/tlnet/
  echo "$(ls -la "$HOME/")"
  ls 'C:\Users\travis'
  tlmgr init-usertree
else
  chmod +x ./install-tl
  ./install-tl -profile ./small.profile -repository http://ctan.mirror.rafal.ca/systems/texlive/tlnet
  tlmgr init-usertree
fi

cd ../..

echo "remove the install directory"
rm -rf $DIRNAME
