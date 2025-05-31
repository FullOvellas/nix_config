{ pkgs, ... }:
{
  services.desktopManager.gnome.enable = true;
  services.displayManager.gdm.enable = true;

  environment.gnome.excludePackages = (
    with pkgs;
    [
      atomix
      cheese
      epiphany
      geary
      gedit
      gnome-tour
      hitori
      iagno
      tali
      totem
    ]
  );
}
