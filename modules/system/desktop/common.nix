{ pkgs, ... }:
{
  environment.sessionVariables = {
    GTK_THEME = "Adwaita:dark";
    #GTK_ICON_THEME = "WhiteSur";
    GLFW_IM_MODULE = "ibus"; # for japanese input
    QT_QPA_PLATFORMTHEME = "qt6ct";
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
