{ pkgs, secrets, ... }:
{
  # cursor
  home.file.".icons/default".source =
    "${pkgs.capitaine-cursors-themed}/share/icons/Capitaine Cursors (Gruvbox)";
  # hyprland configurations
  home.file.".config/hypr/hyprland.conf".text = ''
    monitor = desc:${secrets.secrets.monitor}, preferred@120, 0x0, auto-left, vrr, 1
    ${builtins.readFile ./hyprland/hyprland.conf}
  '';
  home.file.".config/hypr/hyprlock.conf".source = ./hyprland/hyprlock.conf;
  home.file.".config/hypr/hyprpaper.conf".source = ./hyprland/hyprpaper.conf;
  home.file.".config/hypr/hypridle.conf".source = ./hyprland/hypridle.conf;
  home.file.".config/scripts/scrolling-mpris.py".source = ./scripts/scrolling-mpris.py;
  home.file.".config/waybar/config.jsonc".source = ./waybar/config.jsonc;
  home.file.".config/waybar/style.css".source = ./waybar/style.css;
}
