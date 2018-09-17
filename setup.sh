#!/bin/bash

set -e

# check if command is executable
cmd() {
  cmd=$1
  if ! [ -x "$(command -v $cmd)" ]; then
    echo "$cmd not installed" >&2
    return 1
  fi
  echo "$cmd already installed" >&2
}

setup_linux() {
  # bundler
  cmd bundler || sudo gem install bundler
  # inspec
  cmd inspec || curl https://omnitruck.chef.io/install.sh | sudo bash -s -- -P inspec
  # ansible
  cmd ansible || (
    sudo apt-get update;
    sudo apt-get -y install software-properties-common;
    sudo apt-add-repository ppa:ansible/ansible;
    sudo apt-get update;
    sudo apt-get -y install ansible
  )
  # virtualbox, vagrant
  cmd virtualbox || sudo apt-get -y virtualbox
  cmd vagrant || sudo apt-get -y vagrant
}

setup_macos() {
  # bundler
  cmd bundler || sudo gem install bundler
  # package manager
  cmd brew || ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  # virtualbox, vagrant
  cmd vagrant || brew cask install vagrant
  cmd virtualbox || brew cask install virtualbox
}

ostype() {
  case $OSTYPE in
    linux*) setup_linux;;
    darwin*) setup_macos;;
  esac
}

# bundler using Gemfile
bundle install --retry=3 --jobs=4
