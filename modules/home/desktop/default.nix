{ pkgs, ... }:
{
  imports = [
    ./theming.nix
    ./wm
    ./rofi/theme
  ];

  programs = {
    wlogout = {
      enable = true;
      layout = builtins.fromJSON (builtins.readFile ./wlogout/layout.json);
      style = ./wlogout/style.css;
    };
    rofi = {
      enable = true;
      package = pkgs.rofi-wayland;
    };
  };

  services.kdeconnect = {
    enable = true;
    indicator = true;
  };

  home.packages = with pkgs; [
    grim # screenshots
    slurp # screenshot region selector
    swappy # screenshot edit
    hyprland-qtutils
    kdePackages.qt6ct
    wl-clipboard
    ## notifications
    mako
    #dunst
    libnotify
    ## Status bar
    waybar
    ### bar stuff
    blueman
    networkmanagerapplet
    waybar-mpris
    playerctl
    syncthingtray
  ];
}
