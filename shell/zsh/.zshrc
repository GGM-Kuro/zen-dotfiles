typeset -U path cdpath fpath manpath

autoload -U compinit && compinit
# History options should be set in .zshrc and after oh-my-zsh sourcing.
# See https://github.com/nix-community/home-manager/issues/177.
HISTSIZE="10000"
SAVEHIST="10000"

HISTFILE="/home/kuro/.zsh_history"
mkdir -p "$(dirname "$HISTFILE")"

setopt HIST_FCNTL_LOCK

# Enabled history options
enabled_opts=(
  HIST_IGNORE_DUPS HIST_IGNORE_SPACE SHARE_HISTORY
)
for opt in "${enabled_opts[@]}"; do
  setopt "$opt"
done
unset opt enabled_opts

# Disabled history options
disabled_opts=(
  APPEND_HISTORY EXTENDED_HISTORY HIST_EXPIRE_DUPS_FIRST HIST_FIND_NO_DUPS
  HIST_IGNORE_ALL_DUPS HIST_SAVE_NO_DUPS
)
for opt in "${disabled_opts[@]}"; do
  unsetopt "$opt"
done
unset opt disabled_opts

# export JAVA_HOME=/nix/store/imqrk5lxp6fv2xndnz7wndxn4f1mzni2-openjdk-21.0.9+10
[[ ! -d "$HOME/.dotfiles" ]] || export DOTFILES_PATH="$HOME/.dotfiles"
source $DOTFILES_PATH/shell/zsh/init

alias -- ..='cd ..'
alias -- ...='cd ../..'
alias -- .f='cd $DOTFILES_PATH'
alias -- cat=bat
alias -- code='cd $PROJECTS && clear'
alias -- dotfiles='cd $DOTFILES_PATH'
alias -- l='lsd --group-dirs=first'
alias -- la='lsd -a --group-dirs=first'
alias -- ll='lsd -lh --group-dirs=first'
alias -- ls='lsd --group-dirs=first'
alias -- lsa='lsd -lha --group-dirs=first'
alias -- nixdev='nix develop . --system x86_64-linux --command zsh'
alias -- pipenv='source .venv/bin/activate'
alias -- pubspec='flutter pub add'
alias -- t=tmux
alias -- uvenv='uv venv'
alias -- uvinstall='uv pip install'
alias -- uvrun='uv run'
alias -- v=nvim
alias -- vi=nvim
alias -- vim=nvim
alias -- '~'='cd ~'
# Named Directory Hashes
hash -d CODE="$HOME/code"
