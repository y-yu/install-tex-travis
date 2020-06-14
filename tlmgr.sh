#!/usr/bin/env bash

if [[ $IS_WINDOWS == 'true' ]]; then
  tlmgr.bat -repository http://ctan.mirror.rafal.ca/systems/texlive/tlnet $@
else
  tlmgr -repository http://ctan.mirror.rafal.ca/systems/texlive/tlnet $@
fi
