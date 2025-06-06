{ pkgs, ... }:
{
  imports = [
    ./theming.nix
    ./rofi/theme
    ./wm
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

  home.packages = with pkgs; [
    grim # screenshots
    slurp # screenshot region selector
    swappy # screenshot edit
    hyprland-qtutils
    kdePackages.qt6ct
    # moved to home manager rofi-wayland # launcher
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
