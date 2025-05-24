{ ... }:
{
  imports = [
    ./boot.nix
    ./services.nix
    ./desktop
    ./audio.nix
    ./users.nix
    ./i18n.nix
    ./nix.nix
    ./packages.nix
    ./dev
    ./programs
    ./security.nix
    ./network.nix
  ];
}
