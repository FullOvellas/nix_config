{ pkgs, ... }:
{
  home.packages = with pkgs; [
    syncthing
    transmission_4
  ];
}
