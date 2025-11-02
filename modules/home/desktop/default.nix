{ pkgs, inputs, ... }:
{
  imports = [
    ./theming.nix
    ./wm
    # ./rofi/theme
  ];

  gtk.enable = true;
  qt.enable = true;
  services.kdeconnect = {
    enable = false;
    indicator = true;
  };

  home.packages = with pkgs; [
    grim # screenshots
    slurp # screenshot region selector
    swappy # screenshot edit
    hyprland-qtutils
    kdePackages.qt6ct
    wl-clipboard
    inputs.vicinae.packages.${system}.default
    ## notifications
    libnotify
    ## Status bar
    ### bar stuff
    blueman
    networkmanagerapplet
    waybar-mpris
    playerctl
    syncthingtray
  ];
}
