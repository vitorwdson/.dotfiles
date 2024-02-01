export ZSH="$HOME/.oh-my-zsh"
plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
)
source $ZSH/oh-my-zsh.sh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

bindkey '^H' backward-kill-word
alias vim="nvim"

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="$HOME/go/bin:$HOME/.local/scripts/:$HOME/.local/bin/:$HOME/.fzf/bin:$HOME/.cargo/bin:$PATH"
export EDITOR=nvim 

fpath+=${ZDOTDIR:-~}/.zsh_functions

# fzf settings
source "/home/vitorwdson/.fzf/shell/completion.zsh"
source "/home/vitorwdson/.fzf/shell/key-bindings.zsh"

if [ -n "$VIRTUAL_ENV" ]; then
    source $VIRTUAL_ENV/bin/activate;
fi

eval "$(starship init zsh)"
