{
  lib,
  pkgs,
  specialArgs,
  ...
}:
let
  recursiveMerge = lib.foldl lib.recursiveUpdate { };
in
recursiveMerge [
  (import ./boot.nix)
  (import ./services.nix {
    inherit pkgs;
    inherit specialArgs;
  })
  (import ./desktop/desktop.nix {
    inherit recursiveMerge;
    inherit pkgs;
  })
  (import ./audio.nix)
  (import ./users.nix)
  (import ./i18n.nix { inherit pkgs; })
  (import ./nix.nix)
  (import ./packages.nix {
    inherit pkgs;
    inherit specialArgs;
  })
  (import ./dev/dev.nix {
    inherit recursiveMerge;
    inherit pkgs;
  })
  (import ./programs/programs.nix {
    inherit recursiveMerge;
    inherit pkgs;
  })
  (import ./security.nix { inherit pkgs; })
  (import ./network.nix)
]
