{ pkgs, ... }:
{
  # cursor
  home.file.".icons/default".source =
    "${pkgs.capitaine-cursors-themed}/share/icons/Capitaine Cursors (Gruvbox)";
  imports = [
    ./scripts
    ./waybar
  ];
}
