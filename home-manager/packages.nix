{
    config,
    pkgs,
    lib,
    ...
}: {

    home.packages = with pkgs; [

      # system utilities
        bat
        lsd
        fzf
        git
        zoxide
        bash
        cargo

        # programs
        fastfetch
        neovim
        tmux
        zsh
        yazi

        # fonts
        nerd-fonts.mononoki
    ];
}
