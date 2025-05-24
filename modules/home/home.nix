{ pkgs, ... }:
{
  home = {
    stateVersion = "24.05";
    username = "fullovellas";
    homeDirectory = "/home/fullovellas";
    sessionVariables = {
      EDITOR = "nvim";
      TERMINAL = "alacritty";
    };
    packages = with pkgs; [
      nnn # terminal file manager

      # archives
      zip
      xz
      unzip
      p7zip
      gnutar
      gzip

      # utils
      ripgrep # recursively searches directories for a regex pattern
      #    jq # A lightweight and flexible command-line JSON processor
      eza
      fzf # Command-line fuzzy finder
      glow # Command-line Markdown viewer

      # misc
      tree
      gnupg

      # system tools
      ethtool
      pciutils # lspci
      usbutils # lsusb
      # learning
      # build systems
    ];
  };
  programs = {
    zoxide.enable = true;
    home-manager.enable = true;
  };
}
