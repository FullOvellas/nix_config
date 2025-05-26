{ pkgs, inputs, ... }:
{
  services = {
    flatpak.enable = true;
    # gpg
    pcscd.enable = true;
    dbus.packages = [ pkgs.gcr ];
    # yubikey
    udev.packages = [ pkgs.yubikey-personalization ];
    openssh = {
      enable = true;
      # require public key authentication for better security
      settings.PasswordAuthentication = true;
      settings.KbdInteractiveAuthentication = true;
      #settings.PermitRootLogin = "yes";
    };
  };
}
