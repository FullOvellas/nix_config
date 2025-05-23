{ pkgs, ... }:
{
  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;

    desktopManager.gnome.enable = true;
    displayManager.gdm.enable = true;

    # Configure keymap in X11
    xkb = {
      layout = "us";
      variant = "";
    };
  };

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
