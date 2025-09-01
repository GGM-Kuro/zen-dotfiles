{
    config,
    pkgs,
    lix,
    ...
}: let
  nixGLWrap = import ./nixgl.nix pkgs;
in {
   fonts.fontconfig.enable = true;

   programs = {
       zsh = import ./programs/zsh.nix {
        inherit config;
       };
       git = import ./programs/git.nix {
        inherit config;
       };
       tmux = import ./programs/tmux.nix {
        inherit config pkgs;
       };
       bash = import ./programs/bash.nix {
        inherit config;
       };
   };
}
