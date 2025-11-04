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
    indicator = false;
  };

  services.vicinae = {
    enable = true;
    autoStart = true;
    settings = {
      faviconService = "twenty";
      popToRootOnClose = false;
      rootSearch.searchFiles = false;
      theme.name = "gruvbox-dark";
      font.size = 10.5;
      window = {
        csd = true;
        opacity = 0.9;
        rounding = 10;
      };
    };
  };

  home.packages = with pkgs; [
    grim # screenshots
    slurp # screenshot region selector
    swappy # screenshot edit
    hyprland-qtutils
    kdePackages.qt6ct
    wl-clipboard
    baobab
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
