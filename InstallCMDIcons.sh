#!/bin/bash

# NEED
# git
# gperf
# make
# clang
# zsh

echo "Install icons-in-terminal from git";
git clone https://github.com/sebastiencs/icons-in-terminal.git;
cd icons-in-terminal;
./install.sh;

echo "Install ls-icons from git";
cd ..;
git clone https://github.com/sebastiencs/ls-icons.git;
cd ls-icons;
./bootstrap;
export CFLAGS=-DNO_TRUE_COLOURS=1;
export CC=clang CXX=clang++;
./configure --prefix=$HOME/.tools/ls-icons
make;
make install;
echo "alias ls=$HOME/.tools/ls-icons/bin/ls" >> ~/.zshrc;
source ~/.zshrc;


