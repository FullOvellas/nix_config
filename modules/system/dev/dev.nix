{ recursiveMerge, pkgs, ... }:

recursiveMerge [
  (import ./virtualization.nix)
  (import ./environment.nix { inherit pkgs; })
]
