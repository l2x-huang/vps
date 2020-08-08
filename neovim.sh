#!/bin/bash

wget -c https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.tar.gz \
   -O - | tar -xzf -
cp -r nvim-linux64/* $HOME/.local
rm -rf nvim-linux64
