#!/bin/bash

set -e

########
# BREW #
########
# check if brew is installed
if ! which brew > /dev/null; then
  echo -e "Brew not found! Install? (y/n) \c"
  read
  if "$REPLY" = "y"; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  else
    exit
  fi
fi

# install packages
packages="awscli terraform "
packages_with_cask="docker"

for package in $packages; do
  if ! which $package > /dev/null; then
    brew install $package
  fi
done

for package in $packages_with_cask; do
  if ! which $package > /dev/null; then
    brew install --cask $package
  fi
done

# run localstack
localstack start
