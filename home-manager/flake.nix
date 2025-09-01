{
    description = "Kuro: Zen-Config for all systems";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
        nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        flake-utils.url = "github:numtide/flake-utils";
    };

    outputs = {
        nixpkgs,
        nixpkgs-unstable,
        home-manager,
        flake-utils,
        ...
    }: let

      system = "x86_64-linux";
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

      kuro = {
        home = {
          username = user;
          homeDirectory = "/home/${user}";
          stateVersion = stateVersion;
        };

        programs.home-manager.enable = true;
        programs.tmux.enable = true;
        programs.alacritty.enable = true;
        nixpkgs.config.allowUnfree = true;
        imports = [ ./programs.nix ./packages.nix];
      };
    in{
      homeConfigurations = {
          kuro = home-manager.lib.homeManagerConfiguration {
                inherit pkgs;

                extraSpecialArgs = {
                    inherit unstablePkgs;
                };
                modules = [kuro];
          };
      };
    };
}
