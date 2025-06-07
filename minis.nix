# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ ... }:
{
  sops = {
    defaultSopsFile = ./secrets/secrets.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = "/home/fullovellas/.config/sops/age/keys.txt";
    secrets = {
      yubikey_udev_rule = {
        path = "/run/udev/rules.d/99-yubi.rules";
      };
    };
  };
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./modules/system
  ];

  # Enable CUPS to print documents.
  #  services.printing.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

}
