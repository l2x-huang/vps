#!/bin/bash

set -ex

chmod 600 ~/.ssh/id_rsa ~/.ssh/id_rsa.pub
git clone git@github.com:l2x-huang/home.git
cp -r home $HOME
rm -rf home
