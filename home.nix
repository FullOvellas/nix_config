{
  config,
  pkgs,
  lib,
  secrets,
  ...
}:
import ./modules/home/modules.nix {
  inherit config;
  inherit pkgs;
  inherit lib;
  inherit secrets;
}
