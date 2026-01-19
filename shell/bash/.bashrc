[[ ! -d "$HOME/.dotfiles" ]] || export DOTFILES_PATH="$HOME/.dotfiles"
[ ! -e "$HOME/.inputrc" ] && ln -s "$HOME/.dotfiles/shell/bash/inputrc" "$HOME/.inputrc"
source $DOTFILES_PATH/shell/bash/init


# Commands that should be applied only for interactive shells.
[[ $- == *i* ]] || return

HISTFILESIZE=100000
HISTSIZE=10000

shopt -s histappend
shopt -s extglob
shopt -s globstar
shopt -s checkjobs

alias ..='cd ..'
alias ...='cd ../..'
alias .f='cd $DOTFILES_PATH'
alias cat=bat
alias code='cd $PROJECTS && clear'
alias dotfiles='cd $DOTFILES_PATH'
alias l='lsd --group-dirs=first'
alias la='lsd -a --group-dirs=first'
alias ll='lsd -lh --group-dirs=first'
alias ls='lsd --group-dirs=first'
alias lsa='lsd -lha --group-dirs=first'
alias nixdev='nix develop . --system x86_64-linux --command zsh'
alias pipenv='source .venv/bin/activate'
alias pubspec='flutter pub add'
alias t=tmux
alias uvenv='uv venv'
alias uvinstall='uv pip install'
alias uvrun='uv run'
alias v=nvim
alias vi=nvim
alias vim=nvim
alias ~='cd ~'


