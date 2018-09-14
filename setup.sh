#!/bin/bash

set -e

# check if command is executable
cmd() {
  cmd=$1
  if ! [ -x "$(command -v $cmd)" ]; then
    echo "$cmd not installed" >&2
    return 1
  fi
  echo "$cmd is installed" >&2
}

cmd brew || ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
cmd vagrant || brew cask install vagrant
cmd vagrant || brew cask install virtualbox

bundle install
