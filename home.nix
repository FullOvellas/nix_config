{ inputs, ... }:
{
  sops = {
    defaultSopsFile = ./secrets/secrets.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = "/home/fullovellas/.config/sops/age/keys.txt";
    secrets = {
      monitor = { };
    };
  };

  imports = [
    # inputs.nixvim.homeManagerModules.nixvim
    inputs.nvf.homeManagerModules.default
    ./modules/home
  ];
}
