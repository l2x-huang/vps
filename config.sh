#!/bin/bash

set -ex

git clone git@github.com:l2x-huang/home.git
cp -r home $HOME
rm -rf home
