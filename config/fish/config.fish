fish_config theme choose "Dracula Official"
set -g fish_greeting

set PATH $HOME/.yarn/bin $HOME/.config/yarn/global/node_modules/.bin $PATH
set PATH $HOME/go/bin $HOME/.local/scripts/ $HOME/.local/bin/ $HOME/.fzf/bin $HOME/.cargo/bin $PATH
set EDITOR nvim

bind \cH backward-kill-word
alias vim="nvim"

if status is-interactive
    # Commands to run in interactive sessions can go here
end

if test -n "$VIRTUAL_ENV"
    source $VIRTUAL_ENV/bin/activate.fish
end

starship init fish | source
