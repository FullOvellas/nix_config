{ pkgs, inputs, ... }:
{
  services = {
    blueman.enable = true;
    flatpak.enable = false;
    # gpg
    pcscd.enable = true;
    dbus.packages = [ pkgs.gcr ];
    # yubikey
    udev.packages = [ pkgs.yubikey-personalization ];
    openssh = {
      enable = false;
      # require public key authentication for better security
      settings.PasswordAuthentication = true;
      settings.KbdInteractiveAuthentication = true;
      #settings.PermitRootLogin = "yes";
    };
  };
}
