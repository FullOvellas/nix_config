{ recursiveMerge, pkgs, ... }:

recursiveMerge [
  (import ./entertainment.nix)
  (import ./utils.nix { inherit pkgs; })
]
