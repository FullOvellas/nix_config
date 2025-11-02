{ pkgs, ... }:
{
  programs = {
    gnupg.agent = {
      enable = true;
      pinentryPackage = pkgs.pinentry-gnome3;
    };
  };
  security = {
    doas = {
      enable = true;
      extraRules = [
        {
          users = [ "fullovellas" ];
          keepEnv = true;
          persist = true;
        }
      ];
    };
    sudo.enable = true;
    pam.services = {
      login.u2fAuth = true;
      sudo.u2fAuth = true;
      hyprlock = {
        u2fAuth = true;
      };
    };
  };
}
