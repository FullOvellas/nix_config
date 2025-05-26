{ pkgs, ... }:
{
  # cursor
  home.file.".icons/default".source =
    "${pkgs.capitaine-cursors-themed}/share/icons/Capitaine Cursors (Gruvbox)";
  imports = [
    ./hyprland
    ./scripts
    ./waybar
  ];
}
