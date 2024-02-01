# Dotfiles

Here I have most of my important configs and scripts and instructions to install another required stuff

## Installing

To install this, simply run
```bash
./install.sh
```

## Requirements

Here are some programs you might need to install and the (current) way to install them:

- [Kitty](https://sw.kovidgoyal.net/kitty/binary/):
```bash
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
```

- [Oh My Zsh](https://github.com/ohmyzsh/ohmyzsh?tab=readme-ov-file#basic-installation):
```bash
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

- [Starship](https://starship.rs/guide/#%F0%9F%9A%80-installation):
```bash
curl -sS https://starship.rs/install.sh | sh
```

- [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md#oh-my-zsh):
```bash
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

- [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md#oh-my-zsh):
```bash
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```

- [Solaar](https://pwr-solaar.github.io/Solaar/installation):
```bash
sudo dnf install solaar
```

## Some other useful links:

- [Configuring flashing/training for my moonlander](https://github.com/zsa/wally/wiki/Linux-install)
- [Download a nerd font (FiraCode Nerd Font, the best one)](https://www.nerdfonts.com/font-downloads)

