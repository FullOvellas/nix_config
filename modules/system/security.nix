{ pkgs, ... }:
{
  programs = {
    gnupg.agent = {
      enable = true;
      pinentryPackage = pkgs.pinentry-gnome3;
    };
  };
  security.pam.services = {
    login.u2fAuth = true;
    sudo.u2fAuth = true;
    hyprlock = {
      u2fAuth = true;
    };
  };
}
