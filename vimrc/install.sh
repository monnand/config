#!/bin/bash

log-green() {
  local GREEN='\033[0;32m'
  local NC='\033[0m' # No Color
  echo -e "${GREEN} $@ ${NC}"
}

ensure-package() {
  local package=$1
  log-green Installing $package
  sudo apt-get install $package
}

install-vundle() {
  mkdir -p ~/.vim
  if [ -e ~/.vim/bundle/Vundle.vim ]; then
    log-green Updateing Vundle
    cd ~/.vim/bundle/Vundle.vim && git pull
    cd -
  else
    log-green Installing Vundle
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
  fi
}

install-ycm() {
  log-green Installing YCM
  cd ~/.vim/bundle/YouCompleteMe
  ./install.sh --clang-completer
}

install-vundle
ensure-package build-essential
ensure-package cmake
ensure-package python3-dev

cp vimrc ~/.vimrc
vim +PluginClean +qall
vim +PluginInstall +qall

install-ycm
