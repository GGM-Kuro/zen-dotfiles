{
  description = "Kuro: Zen-Config for all systems";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nvim-config = {
      url = "github:GGM-Kuro/zen-nvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
      nvim-config,
      flake-utils,
      ...
    }:
    let

      mkHomeConfig =
        system:
        let
          stateVersion = "23.05";
          user = "kuro";
          pkgs = import nixpkgs {

            inherit system;
            config.allowUnfree = true;

          };

          unstablePkgs = import nixpkgs-unstable {
            inherit system;
            config.allowUnfree = true;
          };
        in
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = {
            inherit unstablePkgs;
          };

          modules = [
            {
              home = {
                username = user;
                shellAliases = import ./aliases.nix;
                packages = [
                  nvim-config.packages.${system}.nvim
                ];
                homeDirectory = "/home/${user}";
                stateVersion = stateVersion;
              };

              programs.home-manager.enable = true;
              programs.tmux.enable = true;
              programs.alacritty.enable = true;
              nixpkgs.config.allowUnfree = true;

              imports = [
                ./programs.nix
                ./packages.nix
              ];
            }
          ];
        };
    in
    {
      homeConfigurations = {
        "x86_64" = mkHomeConfig "x86_64-linux";
        "arch64" = mkHomeConfig "aarch64-linux";

      };
    };
}
