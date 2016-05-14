FROM golang:1.6.2-alpine 
MAINTAINER Christian Sullivan <cs@bodhi5.com> 

ENV VERSION=v6.1.0 NPM_VERSION=3
ENV CMAKE_EXTRA_FLAGS=-DENABLE_JEMALLOC=OFF
ENV SHELL=/bin/zsh

RUN apk add --update git \
  alpine-sdk \
  libtool \
  cmake \
  automake \
  m4 \
  autoconf \
  linux-headers \
  unzip \
  ncurses-dev \
  python \
  py-pip && rm -rf /var/cache/apk/*

RUN apk add --update-cache --no-cache git nodejs zsh openssh tmux python3 && \ 
    apk add --no-cache --virtual build-deps musl-dev gcc python3-dev && \
    python3 -m ensurepip && \
    pip3 install --upgrade pip setuptools && \
    pip3 install neovim && \
    apk del build-deps

RUN git clone https://github.com/neovim/libtermkey.git && \
  cd libtermkey && \
  make && \
  make install && \
  cd ../ && rm -rf libtermkey && \
  git clone https://github.com/neovim/libvterm.git && \
  cd libvterm && \
  make && \
  make install && \
  cd ../ && rm -rf libvterm && \
  git clone https://github.com/neovim/unibilium.git && \
  cd unibilium && \
  make && \
  make install && \
  cd ../ && rm -rf unibilium && \
  git clone https://github.com/neovim/neovim.git && \
  cd neovim && \
  make && \
  make install && \
  cd ../ && rm -rf neovim
