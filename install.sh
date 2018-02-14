#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
ROOT_DIR=/tmp/fakehome
TERM_DIR=$ROOT_DIR/termschemes

confirm() {
    echo "'$1' already exists. Do you want to overwrite it?"
    read -p "Are you sure? [yN] "
    echo    # (optional) move to a new line
    if [[ $REPLY =~ ^[Yy] ]]
    then
        return 1
    fi
    return 0
}

movefile() {
    src=$1
    dst=$2

    if [ ! -d $2 ] && [ ! -f $2 ];
    then
        cp "$1" "$2"
    else
        confirm $2
        if [ $? -eq 1 ]; then
            cp "$1" "$2"
        fi
    fi
}

mkdir -p $TERM_DIR || die "Failed to create directory $TERM_DIR"
mkdir -p $ROOT_DIR/.config/fish/ || die "Failed to create fish config dir"

movefile $DIR/config.fish $ROOT_DIR/.config/fish/config.fish
movefile $DIR/vimrc $ROOT_DIR/.vimrc

if [[ "`uname`" == "Darwin" ]]; then
    movefile $DIR/one.itermcolors $TERM_DIR/one.itermcolors
    cp -r "$DIR/iTerm2-Color-Schemes" "$TERM_DIR/"
fi


if [ ! -f ~/.vim/autoload/plug.vim ];
then
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        htps://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi
