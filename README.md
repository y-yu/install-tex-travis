Install TeXLive2016 to OSX and Linux on Travis CI
====================================================

[![Build Status](https://travis-ci.org/y-yu/install-tex-travis.svg?branch=master)](https://travis-ci.org/y-yu/install-tex-travis)

## How to use

```yml
os:
  - osx
  - linux
dist: trusty
sudo: required
before_install:
  - wget https://raw.githubusercontent.com/y-yu/install-tex-travis/master/install-tex.sh
  - chmod +x install-tex.sh
install:
  - . ./install-tex.sh
```

It is necessary to write `. ./install-tex.sh` on the install step because
this script updates the PATH environment variable. (see [this link](http://stackoverflow.com/a/23936826))
