{ recursiveMerge, pkgs, ... }:

recursiveMerge [
  (import ./gnome.nix { inherit pkgs; })
  (import ./wm.nix)
  (import ./common.nix { inherit pkgs; })
]
