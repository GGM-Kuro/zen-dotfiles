{
  pkgs,
  config,
  ...
}:
{
  enable = true;
  dirHashes = {
    projects = "$HOME/projects";
  };
  initContent = ''
    export JAVA_HOME=${pkgs.jdk}
    export XDG_DATA_DIRS=$HOME/.nix-profile/share:$XDG_DATA_DIRS
    [[ ! -d "$HOME/.dotfiles" ]] || export DOTFILES_PATH="$HOME/.dotfiles"
    source $DOTFILES_PATH/shell/zsh/init
  '';
}
