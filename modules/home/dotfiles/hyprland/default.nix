{ config, ... }:
{
  # hyprland configurations
  home.file.".config/hypr/hyprland.conf".text = ''
    source = ${config.sops.secrets.monitor.path}
    ${builtins.readFile ./hyprland.conf}
  '';
  home.file.".config/hypr/hyprlock.conf".source = ./hyprlock.conf;
  home.file.".config/hypr/hyprpaper.conf".source = ./hyprpaper.conf;
  home.file.".config/hypr/hypridle.conf".source = ./hypridle.conf;
}
