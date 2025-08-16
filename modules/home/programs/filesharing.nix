{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # syncthing
    transmission_4
  ];
  services.syncthing.enable = true;
}
