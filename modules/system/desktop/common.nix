{ pkgs, ... }:
{
  environment.sessionVariables = {
    GLFW_IM_MODULE = "ibus"; # for japanese input
  };
  # fonts
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    zpix-pixel-font
    rounded-mgenplus
    migu
  ];
  hardware.graphics.enable = true;
}
