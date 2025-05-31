{ pkgs, ... }:
{
  stylix = {
    targets = {
      firefox.enable = false;
      nvf.enable = false;
      qt.enable = true;
    };
    iconTheme = {
      enable = true;
      package = pkgs.reversal-icon-theme;
      light = "Reversal";
      dark = "Reversal";
    };
  };
}
