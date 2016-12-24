#!/bin/bash

golang-url() {
  curl -s https://golang.org/dl/ | grep --color=never -o -P "https\://storage\.googleapis\.com/golang/go\d+\.\d+\.\d+\.linux-amd64\.tar\.gz" | head -n 1
}

golang-package() {
  local url=$(golang-url)
  echo $url | grep -o --color=never -P "go\d+\.\d+\.\d+\.linux-amd64\.tar\.gz"
}

url=$(golang-url)
wget -P /tmp $url
pkg=$(golang-package)
sudo tar -C /usr/local -xzf /tmp/$pkg 

mkdir -p $HOME/goproj/bin
mkdir -p $HOME/goproj/pkg
mkdir -p $HOME/goproj/src
