{
  recursiveMerge,
  pkgs,
  lib,
  ...
}:

recursiveMerge [
  (import ./editor.nix { inherit pkgs; })
  (import ./git.nix)
  (import ./shells/shells.nix {
    inherit recursiveMerge;
    inherit pkgs;
    inherit lib;
  })
  (import ./terminal.nix)
]
