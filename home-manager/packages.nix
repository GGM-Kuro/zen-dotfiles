{
  pkgs,
  ...
}:
{

  home.packages = with pkgs; [

    # system utilities
    bat
    nixfmt
    lsd
    fzf
    git
    pnpm
    nixd
    quicktype
    jdk
    stylua
    fontconfig
    corefonts
    ripgrep
    ruff
    docker
    zoxide
    podman
    sqlite
    flutter
    bash
    cargo
    openssh
    xclip
    fd
    gh
    vscode-extensions.dart-code.flutter
    lua-language-server

    unzip
    uv
    btop
    dust
    fastfetch
    imagemagick
    jq
    tree


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
  ];
}
