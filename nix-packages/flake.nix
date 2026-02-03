{
  description = "User packages managed by Nix without Home Manager";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in
    {
      packages.${system}.default = pkgs.buildEnv {
        name = "user-packages";
        paths = with pkgs; [

          # ------------------------------
          # System utilities
          # ------------------------------
          bat
          nixfmt
          lsd
          fzf
          omnisharp-roslyn
          cowsay
          opencode
          lsof
          gcc
          git
          pnpm
          nixd
          quicktype
          jdk
          stylua
          fontconfig
          corefonts
          ripgrep
          neofetch
          ranger
          ruff
          zoxide
          tree-sitter
          sqlite
          flutter
          cargo
          pureref
          xclip
          fd
          gh
          lua-language-server

          unzip
          uv
          btop
          dust
          fastfetch
          imagemagick
          jq
          tree

          # ------------------------------
          # Programs
          # ------------------------------
          lazygit
          posting
          tmux
          yazi
          claude-code

        ];
      };
    };
}
