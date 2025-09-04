{
  config,
  pkgs,
  lib,
  ...
}:
{

  home.packages = with pkgs; [

    # system utilities
    bat
    lsd
    fzf
    git
    # ripgrep
    zoxide
    podman
    bash
    cargo
    openssh
    xclip
    unzip
    uv

    # programs
    fastfetch
    lazygit
    posting
    tmux
    zsh
    yazi

    # fonts
    nerd-fonts.mononoki
  ];
}
