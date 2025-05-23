{
  recursiveMerge,
  lib,
  pkgs,
  ...
}:

recursiveMerge [
  (import ./nushell/nushell.nix {
    inherit lib;
    inherit pkgs;
  })
  (import ./bash.nix)
  (import ./completions.nix)
  (import ./prompt.nix)
]
