{
  config,
  lib,
  pkgs,
  secrets,
  ...
}:
let
  recursiveMerge = lib.foldl lib.recursiveUpdate { };
in
recursiveMerge [
  (import ./programs/programs.nix {
    inherit recursiveMerge;
    inherit pkgs;
    inherit lib;
  })
  (import ./home.nix { inherit pkgs; })
  (import ./services.nix)
  (import ./desktop/desktop.nix {
    inherit config;
    inherit pkgs;
  })
  (import ./dotfiles/dotfiles.nix {
    inherit pkgs;
    inherit secrets;
  })
]
