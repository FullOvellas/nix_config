{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    nautilus
  ];
  programs.nautilus-open-any-terminal = {
    enable = true;
    terminal = "ghostty";
  };
  services.displayManager.gdm.enable = true;
  imports = [
    # ./gnome.nix
    # ./plasma.nix
    ./common.nix
    ./theming.nix
    ./wm.nix
  ];
}
