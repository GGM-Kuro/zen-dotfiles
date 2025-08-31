{config}: {
    enable = true;
    enableCompletion = true;
    bashrcExtra = ''
       [[ ! -d "$HOME/.dotfiles" ]] || export DOTFILES_PATH="$HOME/.dotfiles"
       [ ! -e "$HOME/.inputrc" ] && ln -s "$HOME/.dotfiles/shell/bash/inputrc" "$HOME/.inputrc"
       source $DOTFILES_PATH/shell/bash/init
    '';
}
