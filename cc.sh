#!/bin/bash

# llvm source
echo '
deb http://apt.llvm.org/focal/ llvm-toolchain-focal main
deb-src http://apt.llvm.org/focal/ llvm-toolchain-focal main' >> /etc/apt/sources.list
wget -qO- https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add -

apt update
apt install cmake clangd llvm clang lldb lld llvm-12-dev libc++-12-dev libc++abi-12-dev \
    ninja-build make gdb ccache
