#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

if [[ ! -d "$SCRIPT_DIR/config/nvim" ]]; then
    git clone git@github.com:vitorwdson/nvim-config.git "$SCRIPT_DIR/config/nvim"
fi

if [[ ! -d "$SCRIPT_DIR/backup" ]]; then
    mkdir "$SCRIPT_DIR/backup"
    mkdir "$SCRIPT_DIR/backup/.config"
    mkdir "$SCRIPT_DIR/backup/.local"
fi

function install_config() {
    local path="$1"
    local name=$(basename "$path")
    local destiny_folder="$2"
    local destiny="$HOME/$destiny_folder$name"
    local backup="$SCRIPT_DIR/backup/$destiny_folder$name"

    if [[ -L "$destiny" ]]; then
        unlink "$destiny"
    fi

    if [[ -e "$destiny" ]]; then
        cp -r "$destiny" "$backup"
        rm -rf "$destiny"
    fi

    echo "Linking $path to $destiny"
    ln -s "$path" "$destiny"
}

configs=($SCRIPT_DIR/config/*)
for f in "${configs[@]}"; do
    install_config "$f" ".config/"
done

locals=($SCRIPT_DIR/local/*)
for f in "${locals[@]}"; do
    install_config "$f" ".local/"
done

install_config "$SCRIPT_DIR/zsh/.zshrc" ""

apt=$(command -v apt)
dnf=$(command -v dnf)

function install_package() {
    if [ ! -z "$apt" ]; then
        sudo apt install $1
    elif [ ! -z "$dnf" ]; then
        sudo dnf install $1
    else
        echo "Automatic installation not supported for this system, please install $1"
    fi
}

zsh=$(command -v zsh)
if [ -z "$zsh" ]; then
    echo "Installing zsh"
    install_package zsh
fi

fzf=$(command -v fzf)
if [ -z "$fzf" ]; then
    echo "Installing fzf"
    install_package fzf
fi

ripgrep=$(command -v rg)
if [ -z "$ripgrep" ]; then
    echo "Installing ripgrep"
    install_package ripgrep
fi

zsh=$(command -v zsh)
if [ "$SHELL" != "$zsh" ]; then
    echo "Your default shell is not zsh, trying to change..."

    if [ ! -z "$dnf" ]; then
        sudo lchsh $USER
    else
        chsh -s $(zsh)
    fi
fi
