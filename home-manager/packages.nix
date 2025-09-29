{
  pkgs,
  ...
}:
{

  home.packages = with pkgs; [

    # system utilities
    bat
    lsd
    fzf
    git
    jdk
    fontconfig
    corefonts
    ripgrep
    docker
    zoxide
    podman
    sqlite
    flutter
    bash
    cargo
    openssh
    xclip
    unzip
    uv
    btop
    dust
    fastfetch
    imagemagick
    jq
    

    ##imv  vs  ranger

    # programs
    fastfetch
    lazygit
    lazydocker
    posting
    tmux
    zsh
    yazi

    # fonts
    nerd-fonts.mononoki
    nerd-fonts.fira-code
  ];
}
