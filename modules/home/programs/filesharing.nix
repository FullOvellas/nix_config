{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # syncthing
    transmission_4
    localsend
  ];
  services.syncthing.enable = true;
}
