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
       bash = import ./programs/bash.nix {
        inherit config;
       };
   };
}
