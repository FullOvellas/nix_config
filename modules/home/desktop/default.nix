{
  pkgs,
  lib,
  ...
}:
{
  imports = [
    ./theming.nix
    ./wm
    ./shell
    # ./rofi/theme
  ];

  gtk.enable = true;
  qt.enable = true;
  services.kdeconnect = {
    enable = false;
    indicator = false;
  };

  programs.rofi.enable = false;

  services.vicinae = {
    systemd.enable = true;
    enable = true;
    settings = {
      faviconService = "twenty";
      popToRootOnClose = false;
      rootSearch.searchFiles = false;
      # theme.name = "gruvbox-dark";
      font.size = 10.5;
      window = {
        csd = true;
        opacity = lib.mkForce 0.9;
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
    playerctl
    syncthingtray
  ];
}
