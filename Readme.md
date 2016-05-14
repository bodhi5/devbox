# Bodhi5 DevBox

Dockerized Dev Environment

## Tools

- zsh
  - oh-my-zsh
- git
- openssh
- golang
- nodejs
- tmux
- neovim
  - vim-plug
  - other plugins

## Build

```bash
$ docker build -t devbox --build-arg USER_NAME=_SOME_USER_NAME_ .
```

## Run

```bash
$ docker run -v $GOPATH/src:/go/src -v $HOME/.ssh:/home/_SOME_USER_NAME_/.ssh -it devbox
```

## License

MIT
