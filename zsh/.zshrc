has_keychain=$(command -v keychain)
if [ -n "$has_keychain" ]; then
  eval $(keychain --eval --quiet --nogui --noask id_ed25519)
fi

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

bindkey '^H' backward-kill-word

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
)
source $ZSH/oh-my-zsh.sh

fpath+=${ZDOTDIR:-~}/.zsh_functions
source <(fzf --zsh)

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export PATH="/usr/local/go/bin:$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="$HOME/go/bin:$HOME/.local/scripts:$HOME/.local/bin:$HOME/.fzf/bin:$HOME/.cargo/bin:$PATH"
export EDITOR=nvim 
export UV_PROJECT_ENVIRONMENT=venv

alias vim="nvim"
alias ls='lsd'
alias lt='ls --tree'

LOCAL_RC_FILE="$HOME/.zshrc.local"
if [ -f $LOCAL_RC_FILE ]; then
    source $LOCAL_RC_FILE
fi

if [ -n "$PY_VENV" ]; then
    source $PY_VENV/bin/activate;
fi

eval "$(direnv hook zsh)"
