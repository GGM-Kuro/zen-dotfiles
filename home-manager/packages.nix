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
    	ripgrep
        zoxide
        bash
        cargo
	    openssh
        uv

        # programs
        fastfetch
        lazygit
        posting
        neovim
        tmux
        zsh
        yazi

        # fonts
        nerd-fonts.mononoki
    ];
}
