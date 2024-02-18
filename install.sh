#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

echo ""
echo "Linking config files and scripts..."
echo ""
echo ""

if [[ ! -d "$SCRIPT_DIR/config/nvim" ]]; then
    git clone git@github.com:vitorwdson/nvim-config.git "$SCRIPT_DIR/config/nvim"
fi

if [[ ! -d "$SCRIPT_DIR/backup" ]]; then
    mkdir -p "$SCRIPT_DIR/backup/.config/systemd/user"
    mkdir -p "$SCRIPT_DIR/backup/.local"
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

install_config "$SCRIPT_DIR/systemd/ssh-agent.service" ".config/systemd/user/"

echo ""
read -p "Do you wish to install the required packages (apt or dnf only)? (y/N): " confirm
echo ""

if [[ "$confirm" =~ ^[Yy]$ ]]; then
    echo "installing required packages..."
    echo ""

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

    zsh=$(command -v fish)
    if [ -z "$zsh" ]; then
        echo "Installing zsh"
        install_package zsh
    fi

    tmux=$(command -v tmux)
    if [ -z "$tmux" ]; then
        echo "Installing tmux"
        install_package tmux
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

    OHMYZSH_DIR="$HOME/.oh-my-zsh"
    if [[ ! -d "$OHMYZSH_DIR" ]]; then
        echo "Installing oh-my-zsh"
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    fi

    ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"
    if [[ ! -d "$ZSH_CUSTOM/themes/powerlevel10k" ]]; then
        echo "Installing powerlevel10k"
        git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM}/themes/powerlevel10k
    fi

    if [[ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]]; then
        echo "Installing zsh-syntax-highlighting"
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting
    fi

    if [[ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]]; then
        echo "Installing zsh-autosuggestions"
        git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM}/plugins/zsh-autosuggestions
    fi
fi

install_config "$SCRIPT_DIR/zsh/.zshrc" ""
install_config "$SCRIPT_DIR/zsh/.p10k.zsh" ""

if [[ $confirm =~ ^[Yy]$ ]]; then
    zsh=$(command -v fish)
    if [ "$SHELL" != "$zsh" ]; then
        echo "Your default shell is not zsh, trying to change..."

        if [ ! -z "$dnf" ]; then
            echo "Insert \"/bin/zsh\""
            sudo lchsh $USER
        else
            chsh -s $(zsh)
        fi
    fi
fi

echo ""
echo ""
echo "Here are some programs you might need to install and the (current) way to install them:"
echo ""
echo "Kitty:"
echo "curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin"
echo ""
echo "Solaar:"
echo "sudo dnf install solaar"

echo ""
echo ""
echo "Some other useful links:"
echo ""
echo "Configuring flashing/training for my moonlander:"
echo "https://github.com/zsa/wally/wiki/Linux-install"
echo ""
echo "Download a nerd font (FiraCode Nerd Font, the best one)"
echo "https://www.nerdfonts.com/font-downloads"
