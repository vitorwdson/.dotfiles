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

function install() {
    local path="$1"
    local name=$(basename "$path")
    local destiny_folder="$2"
    local destiny="$HOME/$destiny_folder/$name"
    local backup="$SCRIPT_DIR/backup/$destiny_folder/$name"

    if [[ -e "$destiny" ]]; then
        cp -r "$destiny" "$backup"
        rm -rf "$destiny"
    fi

    ln -s "$path" "$destiny"
}

configs=($SCRIPT_DIR/config/*)
for f in "${configs[@]}"; do
    install "$f" ".config"
done

locals=($SCRIPT_DIR/local/*)
for f in "${locals[@]}"; do
    install "$f" ".local"
done
