FROM bodhi5/devbase 
MAINTAINER Christian Sullivan <cs@bodhi5.com> 

ARG USER_NAME

RUN addgroup -g 1000 $USER_NAME && adduser -D -G $USER_NAME -s /bin/false -u 1000 $USER_NAME && \
    echo '$USER_NAME ALL=(ALL) ALL' >> /etc/sudoers && \
    echo $USER_NAME:$USER_NAME | chpasswd --des

VOLUME /go/src/
VOLUME /home/$USER_NAME/.ssh

RUN chown -R $USER_NAME:$USER_NAME /home/$USER_NAME/.ssh
RUN chown -R $USER_NAME:$USER_NAME /go/src

USER $USER_NAME 

WORKDIR /home/$USER_NAME

RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

RUN curl -fLo $HOME/.config/nvim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

RUN git clone https://github.com/bodhi5/.dotfiles.git && \
    mv .dotfiles/nvim/* $HOME/.config/nvim/ && \
    mv .dotfiles/tmux.conf $HOME/.tmux.conf && \
    mv .dotfiles/zshrc $HOME/.zshrc && \
    mv .dotfiles/zshrc.extras $HOME/.zshrc.extras && \
    ln -s $HOME/.config/nvim $HOME/.vim && \
    ln -s $HOME/.config/nvim/init.vim $HOME/.vimrc


RUN nvim --headless -c "PlugInstall! | qall! " &> /dev/null; exit 0;
RUN nvim --headless +UpdateRemotePlugins +GoInstallBinaries +q!

ENTRYPOINT /bin/zsh
