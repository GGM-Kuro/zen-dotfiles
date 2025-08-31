{config}: {
    enable = true;
    dirHashes = {
      projects = "$HOME/projects";
    };
    initContent = ''
      [[ ! -d "$HOME/.dotfiles" ]] || export DOTFILES_PATH="$HOME/.dotfiles"
      source $DOTFILES_PATH/shell/zsh/init
    '';
}
