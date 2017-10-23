#!/usr/bin/env bash
#

echo ">> Zim installation ..."
if [ -d $HOME/.zim ]
then
  echo ">>> Zim found, skip ..."
else
  echo ">>> Zim not found, clone ..."
  git clone https://github.com/Eriner/zim.git $HOME/.zim

  cd "$HOME/.zim"
  if [[ $(zsh --version | awk '{print $2}') < 5.2.0 ]]; then
    echo ">>> ZSH < 5.2 detected, installing legacy zim"
    git checkout zsh-5.0
  fi
  
  git submodule update --init --recursive
fi
