{
  programs.bash = {
    enable = true;
    enableCompletion = true;
    shellAliases = {
      ls = "eza";
      ll = "eza -l";
      lll = "eza -la";
      sys-up = "sudo nix flake update && git add . && git commit -m \"flake update\" && git push && sudo nixos-rebuild switch && sudo nix-collect-garbage --delete-old";
    };
    bashrcExtra = "export EDITOR=nvim";
  };
}
