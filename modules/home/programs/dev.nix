{ pkgs, pkgs-stable, ... }:
{
  programs.lazydocker = {
    enable = true;
  };

  home.packages =
    with pkgs;
    let
      vscodiumExtensions = inputs.nix-vscode-extensions.extensions."x86_64-linux";
    in
    [
      (vscode-with-extensions.override {
        vscode = vscodium;
        vscodeExtensions = with vscodiumExtensions; [
        ];
      })
      # pkgs-stable.jetbrains.idea-community # [use this if unstable breaks]
      jetbrains.idea-community-bin
    ];
}
